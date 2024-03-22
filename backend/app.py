from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import requests
import os
from flask_session import Session
from flask import session
from requests import Response

app = Flask(__name__)

# Database configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://penjud:#18Hoppy70@localhost/puntbot'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Environment variables for Betfair API
BETFAIR_API_KEY = os.getenv('BETFAIR_API_KEY')
BETFAIR_USERNAME = os.getenv('BETFAIR_USERNAME')
BETFAIR_PASSWORD = os.getenv('BETFAIR_PASSWORD')

# Paths to your certificate and key files
CERT_FILE_PATH = '/home/tim/VScode Projects/PuntBot/backend/certs/client-2048.crt'
KEY_FILE_PATH = '/home/tim/VScode Projects/PuntBot/backend/certs/client-2048.key'

# Betfair API URL (modify if different)
BETFAIR_LOGIN_URL = 'https://identitysso-cert.betfair.com/api/certlogin'

@app.route('/betfair/login')
def betfair_login():
    headers = {
        'X-Application': BETFAIR_API_KEY,
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    try:
        json_response = Response().json()
        session['betfair_session_token'] = json_response['sessionToken']
        return json_response
    except ValueError as e:
        print(f"Status Code: {Response().status_code}")
        print(f"Response Body: {Response().text[:500]}")  # Print first 500 characters of response to avoid flooding the terminal
    # ...

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

# Configure server-side session
app.config['SESSION_TYPE'] = 'filesystem'
app.config['SESSION_FILE_DIR'] = 'flask_session'  # Folder for storing session files
Session(app)

@app.route('/')
def hello():
    return "Hello, PuntBot!"

if __name__ == '__main__':
    app.run(debug=True)

    with app.app_context():
        db.create_all()

