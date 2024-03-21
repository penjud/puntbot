import requests
from dotenv import load_dotenv
import os

load_dotenv()

class BetfairAPI:
    def __init__(self):
        self.username = os.getenv('BETFAIR_USERNAME')
        self.password = os.getenv('BETFAIR_PASSWORD')
        self.api_key = os.getenv('BETFAIR_API_KEY')
        self.session_token = None
        self.base_url = 'https://api-au.betfair.com/exchange/betting/rest/v1.0/'

def login(self):
    login_url = 'https://identitysso.betfair.com.au/api/login'
    payload = {
        'username': self.username,
        'password': self.password,
    }
    headers = {
        'X-Application': self.api_key,
        'Content-Type': 'application/x-www-form-urlencoded',
    }
    response = requests.post(login_url, data=payload, headers=headers)
    
    if response.status_code == 200:
        json_response = response.json()
        self.session_token = json_response['token']
        print('Login successful')
    else:
        print('Login failed')

    def get_markets(self, event_ids):
        markets_url = self.base_url + 'listMarketCatalogue'
        headers = {
            'X-Application': self.api_key,
            'X-Authentication': self.session_token,
            'Content-Type': 'application/json',
        }
        payload = {
            'filter': {
                'eventIds': event_ids,
            },
            'maxResults': 100,
            'marketProjection': ['RUNNER_DESCRIPTION', 'RUNNER_METADATA', 'MARKET_START_TIME'],
        }
    response = requests.post(markets_url, json=payload, headers=headers)
    
    if response.status_code == 200:
        return response.json()
    else:
        print('Failed to retrieve market data')
        return None
    # Implement other methods to interact with the Betfair API as needed