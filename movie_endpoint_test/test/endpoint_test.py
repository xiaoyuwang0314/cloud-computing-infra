import pytest
import requests

# test-1-healthcheck
def test_healthcheck(baseurl):
    response = requests.get(f"{baseurl}/healthcheck")
    assert response.status_code == 200
    assert response.json() == {'database': 'healthy', 'status': 'OK'}

# test-2-login
def test_login_success(user_credentials, baseurl):
    response = requests.post(f"{baseurl}/login", json=user_credentials)
    assert response.status_code == 200
    assert 'token' in response.json()

def test_login_fail(baseurl, invalid_credentials):
    response = requests.post(f"{baseurl}/login", json=invalid_credentials)
    assert response.status_code == 401
    assert 'Invalid' in response.text

# test-3-movie
@pytest.mark.parametrize("endpoint", ["/movie/1", "/movie?id=1"])
def test_movie_endpoint(endpoint, auth_token, baseurl):
    headers = {'Authorization': f'Bearer {auth_token}'}
    response = requests.get(f"{baseurl}{endpoint}", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert data["movieId"] == 1
    assert "title" in data
    assert "genres" in data
    assert isinstance(data["genres"], list)

def test_movie_endpoint_not_found(auth_token, baseurl):
    headers = {'Authorization': f'Bearer {auth_token}'}
    response = requests.get(f"{baseurl}/movie/999999", headers=headers)
    assert response.status_code == 404
    assert response.json() == {"error": "Movie not found"}

# test-4-rating
def test_rating_endpoint(auth_token, baseurl):
    headers = {'Authorization': f'Bearer {auth_token}'}
    response = requests.get(f"{baseurl}/rating/1", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert data["movieId"] == 1
    assert isinstance(data["average_rating"], float)

def test_rating_endpoint_not_found(auth_token, baseurl):
    headers = {'Authorization': f'Bearer {auth_token}'}
    response = requests.get(f"{baseurl}/rating/999999", headers=headers)
    assert response.status_code == 404
    assert response.json() == {"error": "No ratings found for this movie"}

# test-5-link
def test_link_endpoint(auth_token, baseurl):
    headers = {'Authorization': f'Bearer {auth_token}'}
    response = requests.get(f"{baseurl}/link/1", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert data["movieId"] == 1
    assert 'imdbId' in response.json()
    assert 'tmdbId' in response.json()

def test_link_endpoint_not_found(auth_token, baseurl):
    headers = {'Authorization': f'Bearer {auth_token}'}
    response = requests.get(f"{baseurl}/link/999999", headers=headers)
    assert response.status_code == 404
    assert response.json() == {"error": "No links found for this movie"}

# test-6-unauthorized
def test_unauthorized_access(baseurl):
    response = requests.get(f"{baseurl}/movie/1")
    assert response.status_code == 401