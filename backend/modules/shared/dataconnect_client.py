"""
Data Connect Client for Cloud SQL operations
"""

from typing import Dict, Any, Optional
import requests
import json
from datetime import datetime
from config.settings import settings
from google.auth import jwt
from google.auth.transport import requests as auth_requests

class DataConnectClient:
    """
    Client for interacting with Firebase Data Connect
    """

    def __init__(self):
        self.endpoint = settings.DATA_CONNECT_ENDPOINT
        self.project_id = settings.DATA_CONNECT_PROJECT_ID
        self.location = settings.DATA_CONNECT_LOCATION
        self.service = settings.DATA_CONNECT_SERVICE
        self.connector = settings.DATA_CONNECT_CONNECTOR

    def _get_access_token(self) -> str:
        """
        Get access token for Data Connect API using Service Account
        """
        if settings.DEBUG:
            # In debug mode (local), if we have the emulator running, we might still want a token
            # But the emulator often accepts any token or specific mock formats.
            # Assuming real auth is preferred to test connectivity unless explicitly disabled.
            pass

        try:
            from google.oauth2 import service_account
            import google.auth.transport.requests

            creds = service_account.Credentials.from_service_account_file(
                settings.FIREBASE_CREDENTIALS_PATH,
                scopes=['https://www.googleapis.com/auth/cloud-platform']
            )
            
            auth_req = google.auth.transport.requests.Request()
            creds.refresh(auth_req)
            
            return creds.token

        except Exception as e:
            print(f"⚠️ Failed to get real access token: {e}")
            # Fallback for development if file missing or error
            return "mock-token-fallback"

    def execute_mutation(self, mutation_name: str, variables: Dict[str, Any]) -> Dict[str, Any]:
        """
        Execute a Data Connect mutation
        """
        access_token = self._get_access_token()

        url = f"{self.endpoint}/v1/projects/{self.project_id}/locations/{self.location}/services/{self.service}/connectors/{self.connector}:executeMutation"

        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        payload = {
            "mutation": mutation_name,
            "variables": variables
        }

        try:
            response = requests.post(url, headers=headers, json=payload)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"Data Connect mutation failed: {str(e)}")

    async def create_business_and_admin(
        self,
        business_id: str,
        business_name: str,
        user_email: str,
        user_first_name: str,
        user_last_name: str,
        user_mobile: str,
        auth_uid: str,
        user_profile_photo: Optional[str] = None
    ) -> Dict[str, Any]:
        """
        Execute the CreateBusinessAndAdmin mutation
        """
        variables = {
            "businessId": business_id,
            "businessName": business_name,
            "userEmail": user_email,
            "userFirstName": user_first_name,
            "userLastName": user_last_name,
            "userMobile": user_mobile,
            "userProfilePhoto": user_profile_photo,
            "authUid": auth_uid,
            "today": datetime.utcnow().strftime("%Y-%m-%d")
        }

        try:
            result = self.execute_mutation("CreateBusinessAndAdmin", variables)
            return result
        except Exception as e:
            raise Exception(f"Failed to create business and admin: {str(e)}")