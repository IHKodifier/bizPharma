
import httpx
import json
from typing import Dict, Any, Optional
from config.settings import settings

class DataConnectClient:
    """
    Client for interacting with Firebase Data Connect.
    Handles GraphQL requests to both emulator and production endpoints.
    """
    
    def __init__(self):
        self.endpoint = settings.DATA_CONNECT_ENDPOINT
        self.project_id = settings.DATA_CONNECT_PROJECT_ID
        self.location = settings.DATA_CONNECT_LOCATION
        self.service_id = settings.DATA_CONNECT_SERVICE
        self.connector = settings.DATA_CONNECT_CONNECTOR
        
        print(f"DEBUG: DATA_CONNECT_ENDPOINT={self.endpoint}")
        print(f"DEBUG: DATA_CONNECT_PROJECT_ID={self.project_id}")
        
        # Determine if running against emulator
        self.is_emulator = "127.0.0.1" in self.endpoint or "localhost" in self.endpoint
        print(f"DEBUG: is_emulator={self.is_emulator}")

    def _get_url(self, operation_name: str) -> str:
        """Construct the URL for the GraphQL operation"""
        if self.is_emulator:
            # Emulator URL structure: http://host:port/graphql
            return f"{self.endpoint}/graphql"
        else:
            # Production URL structure: 
            # https://firebasedataconnect.googleapis.com/v1beta/projects/{project}/locations/{location}/services/{service}/connectors/{connector}:executeGraphql
            return f"https://firebasedataconnect.googleapis.com/v1beta/projects/{self.project_id}/locations/{self.location}/services/{self.service_id}/connectors/{self.connector}:executeGraphql"

    async def execute_graphql(
        self, 
        query: str, 
        operation_name: str,
        variables: Optional[Dict[str, Any]] = None,
        token: Optional[str] = None
    ) -> Dict[str, Any]:
        """
        Execute a GraphQL query or mutation.
        
        Args:
            query: The GraphQL query string
            operation_name: The name of the operation (required for Data Connect)
            variables: Dictionary of variables
            token: Firebase ID token for authentication
            
        Returns:
            Dict containing the 'data' or 'errors' from the response
        """
        url = self._get_url(operation_name)
        
        headers = {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": "YOUR_API_KEY_HERE" # TODO: Need to handle API Key for prod
        }
        
        if token:
            headers["Authorization"] = f"Bearer {token}"
            
        payload = {
            "query": query,
            "operationName": operation_name,
            "variables": variables or {}
        }
        
        async with httpx.AsyncClient() as client:
            try:
                response = await client.post(url, json=payload, headers=headers, timeout=10.0)
                response.raise_for_status()
                return response.json()
            except httpx.HTTPError as e:
                print(f"❌ Data Connect Request Failed: {e}")
                if hasattr(e, 'response') and e.response:
                    print(f"Response: {e.response.text}")
                raise

# Global instance
data_connect_client = DataConnectClient()
