import pytest
import requests

import os
from dotenv import load_dotenv

# import .env variables
load_dotenv()

@pytest.fixture
def user_credentials():
    return {
        "email": os.getenv('admin_user'),
        "password": os.getenv('admin_pass')
    }

@pytest.fixture
def invalid_credentials():
    return {
        "email": os.getenv('admin_user'),
        "password": "123"
    }

@pytest.fixture
def baseurl():
    return f"http://{os.getenv('app_ip')}/v1"

@pytest.fixture
def auth_token(user_credentials, baseurl):
    response = requests.post(f"{baseurl}/login", json=user_credentials)
    assert response.status_code == 200
    return response.json()['token']
