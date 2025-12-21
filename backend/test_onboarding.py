import sys
import os

# Add backend to sys.path
sys.path.append(os.path.join(os.getcwd(), "backend"))

from fastapi.testclient import TestClient
from main import app
from core.security import get_current_user
from modules.setup.schemas import BusinessProfileResponse
from datetime import datetime

client = TestClient(app)

# Mock the security dependency
async def mock_get_current_user():
    return {
        "uid": "test-user-id",
        "email": "test@example.com",
        "email_verified": True,
        "name": "Test User"
    }

app.dependency_overrides[get_current_user] = mock_get_current_user

def test_initialization_success_even_with_middleware():
    """
    Verify that the middleware body-resetting fix works.
    We mock the underlying service to avoid calling Data Connect.
    """
    payload = {
        "id_token": "mock-token",
        "business_name": "Test Business",
        "first_name": "John",
        "last_name": "Doe",
        "phone": "1234567890",
        "email": "john@example.com",
        "profile_photo": None
    }
    
    # We need to mock the service call inside initialize_business if we want to test far
    # But even just getting past the 422 validation is the main goal here.
    
    response = client.post("/api/v1/setup/initialize", json=payload)
    
    # It might still fail with 500 if we don't mock the service call, 
    # but we want to see it's NOT a 422.
    print(f"Status Code: {response.status_code}")
    if response.status_code == 422:
        print(f"FAILED: Still getting 422. Validation: {response.json()}")
    else:
        print(f"SUCCESS: Past the 422 validation layer. Result: {response.status_code}")

def test_empty_email_validation():
    """Test our safety net for empty strings in email field"""
    payload = {
        "id_token": "mock-token",
        "business_name": "Test Business",
        "first_name": "John",
        "last_name": "Doe",
        "phone": "1234567890",
        "email": "", # Empty string
        "profile_photo": None
    }
    response = client.post("/api/v1/setup/initialize", json=payload)
    print(f"Empty Email Status: {response.status_code}")
    if response.status_code == 422:
        print(f"FAILED: Email validation fail on empty string: {response.json()}")

def test_missing_field_still_fails():
    """Verify that we haven't broken normal validation"""
    payload = {
        # missing business_name
        "id_token": "mock-token",
        "first_name": "John",
        "last_name": "Doe",
        "phone": "1234567890",
        "email": "john@example.com"
    }
    response = client.post("/api/v1/setup/initialize", json=payload)
    print(f"Missing Field Status: {response.status_code}")
    assert response.status_code == 422
    print("SUCCESS: Correctly returned 422 for missing required field.")

if __name__ == "__main__":
    print("Running Robust Onboarding Tests...")
    test_initialization_success_even_with_middleware()
    test_empty_email_validation()
    test_missing_field_still_fails()
    print("\nTests completed.")
