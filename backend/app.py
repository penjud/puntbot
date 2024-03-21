import os
import requests
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Environment variables for Betfair API
BETFAIR_API_KEY = os.getenv('BETFAIR_API_KEY')
BETFAIR_USERNAME = os.getenv('BETFAIR_USERNAME')
BETFAIR_PASSWORD = os.getenv('BETFAIR_PASSWORD')

# Betfair API URL (modify if different)
BETFAIR_LOGIN_URL = 'https://identitysso.betfair.com.au/api/login'

@app.route('/betfair/login')
def betfair_login():
    headers = {
        'X-Application': BETFAIR_API_KEY,
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    login_data = {
        'username': BETFAIR_USERNAME,
        'password': BETFAIR_PASSWORD
    }
    response = requests.post(BETFAIR_LOGIN_URL, data=login_data, headers=headers)
    return response.json()

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://penjud:#18Hoppy70@localhost/puntbot'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Events(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    betfair_id = db.Column(db.String(255), unique=True, nullable=False)
    name = db.Column(db.String(255), nullable=False)
    start_time = db.Column(db.DateTime, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=True)  # Assuming you have a Users table
    bet_amount = db.Column(db.Numeric(10, 2), nullable=True)
    odds = db.Column(db.Numeric(5, 2), nullable=True)
    placed_at = db.Column(db.DateTime, default=db.func.current_timestamp())
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp())
    updated_at = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp())

@app.route('/')
def hello():
    return "Hello, PuntBot!"

if __name__ == '__main__':
    app.run(debug=True)

    with app.app_context():
        db.create_all()

