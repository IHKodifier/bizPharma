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
import logging

logger = logging.getLogger(__name__)

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

    def execute_mutation(self, mutation_name: str, variables: Dict[str, Any], id_token: Optional[str] = None) -> Dict[str, Any]:
        """
        Execute a Data Connect mutation
        """
        if id_token:
            access_token = id_token
        else:
            access_token = self._get_access_token()

        # Emulator usually requires v1beta, Production uses v1
        api_version = "v1beta" if settings.ENV == "DEV" else "v1"
        url = f"{self.endpoint}/{api_version}/projects/{self.project_id}/locations/{self.location}/services/{self.service}/connectors/{self.connector}:executeMutation"

        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        payload = {
            "operationName": mutation_name,
            "variables": variables
        }

        try:
            logger.debug(f"🚀 EXECUTING GQL: {mutation_name}")
            logger.debug(f"   URL: {url}")
            
            # Safe logging of payload
            logger.debug(f"   PAYLOAD: {json.dumps(payload, indent=2)}")

            response = requests.post(url, headers=headers, json=payload)
            
            # Log Data Connect response details
            logger.debug(f"📥 Data Connect Response [{response.status_code}]")
            try:
                response_json = response.json()
                logger.debug(f"   RESPONSE BODY: {json.dumps(response_json, indent=2)}")
            except:
                logger.debug(f"   RESPONSE BODY (raw): {response.text}")

            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            error_msg = f"Data Connect mutation failed: {str(e)}"
            if hasattr(e, 'response') and e.response is not None:
                error_msg += f" | Body: {e.response.text}"
            logger.error(f"❌ {error_msg}")
            raise Exception(error_msg)

    def execute_query(self, query_name: str, variables: Dict[str, Any], id_token: Optional[str] = None) -> Dict[str, Any]:
        """
        Execute a Data Connect query
        """
        if id_token:
            access_token = id_token
        else:
            access_token = self._get_access_token()

        api_version = "v1beta" if settings.ENV == "DEV" else "v1"
        url = f"{self.endpoint}/{api_version}/projects/{self.project_id}/locations/{self.location}/services/{self.service}/connectors/{self.connector}:executeQuery"

        headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        }

        payload = {
            "operationName": query_name,
            "variables": variables
        }

        try:
            logger.debug(f"🔍 EXECUTING GQL QUERY: {query_name}")
            logger.debug(f"   URL: {url}")
            logger.debug(f"   PAYLOAD: {json.dumps(payload, indent=2)}")

            response = requests.post(url, headers=headers, json=payload)
            
            logger.debug(f"📥 Data Connect Response [{response.status_code}]")
            try:
                response_json = response.json()
                logger.debug(f"   RESPONSE BODY: {json.dumps(response_json, indent=2)}")
            except:
                logger.debug(f"   RESPONSE BODY (raw): {response.text}")

            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            error_msg = f"Data Connect query failed: {str(e)}"
            if hasattr(e, 'response') and e.response is not None:
                error_msg += f" | Body: {e.response.text}"
            logger.error(f"❌ {error_msg}")
            raise Exception(error_msg)

    async def create_business_and_admin(
        self,
        id_token: str,
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
            result = self.execute_mutation("CreateBusinessAndAdmin", variables, id_token=id_token)
            return result
        except Exception as e:
            raise Exception(f"Failed to create business and admin: {str(e)}")