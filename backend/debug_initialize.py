import requests
import json

def test_initialize():
    url = "http://127.0.0.1:8000/api/v1/setup/initialize"
    
    test_cases = [
        {
            "name": "Standard Payload",
            "payload": {
                "id_token": "mock-token",
                "business_name": "Test Biz",
                "first_name": "Test",
                "last_name": "User",
                "phone": "123456",
                "email": "test@example.com",
                "profile_photo": None
            }
        },
        {
            "name": "Empty Email (Safety Net)",
            "payload": {
                "id_token": "mock-token",
                "business_name": "Test Biz",
                "first_name": "Test",
                "last_name": "User",
                "phone": "123456",
                "email": "",
                "profile_photo": None
            }
        },
        {
            "name": "Long Phone (Truncation Safeguard)",
            "payload": {
                "id_token": "mock-token",
                "business_name": "Test Biz",
                "first_name": "Test",
                "last_name": "User",
                "phone": "+92 300 1234567890 (Work)",
                "email": "test@example.com",
                "profile_photo": None
            }
        },
        {
            "name": "Missing Required Field (Should still 422)",
            "payload": {
                "id_token": "mock-token",
                "first_name": "Test",
                "last_name": "User",
                "phone": "123456",
                "email": "test@example.com",
                "profile_photo": None
            }
        }
    ]
    
    headers = {
        "Authorization": "Bearer mock-token",
        "Content-Type": "application/json"
    }
    
    for case in test_cases:
        print(f"\n--- Testing: {case['name']} ---")
        try:
            response = requests.post(url, json=case['payload'], headers=headers)
            print(f"Status Code: {response.status_code}")
            print(f"Response: {json.dumps(response.json(), indent=2)}")
        except Exception as e:
            print(f"Request failed: {e}")

if __name__ == "__main__":
    test_initialize()
