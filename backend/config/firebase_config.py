"""
Firebase Admin SDK Configuration

Manages Firebase Admin SDK initialization and provides access to Firebase services.
"""

import firebase_admin
from firebase_admin import credentials, auth, firestore
from typing import Optional
import os

from .settings import settings


class FirebaseConfig:
    """Firebase Admin SDK configuration and initialization"""
    
    def __init__(self):
        self._app: Optional[firebase_admin.App] = None
        self._db: Optional[firestore.Client] = None
        
    def initialize(self) -> firebase_admin.App:
        """
        Initialize Firebase Admin SDK
        
        Returns:
            firebase_admin.App: Initialized Firebase app instance
            
        Raises:
            FileNotFoundError: If service account key file not found
            ValueError: If Firebase app already initialized
        """
        if self._app:
            print("⚠️  Firebase already initialized")
            return self._app
        
        cred_path = settings.FIREBASE_CREDENTIALS_PATH
        
        # Check if credentials file exists
        if not os.path.exists(cred_path):
            print(f"❌ Firebase credentials not found at: {cred_path}")
            # ... (omitted print lines)
            raise FileNotFoundError(
                f"Firebase service account key not found at {cred_path}"
            )
        
        # Set Auth Emulator if in DEV mode
        if settings.ENV == "DEV":
            os.environ["FIREBASE_AUTH_EMULATOR_HOST"] = "127.0.0.1:9099"
            print("🔧 Using Firebase Auth Emulator at 127.0.0.1:9099")
        else:
            # Explicitly remove it if it was set somehow
            if "FIREBASE_AUTH_EMULATOR_HOST" in os.environ:
                del os.environ["FIREBASE_AUTH_EMULATOR_HOST"]
        
        try:
            # Initialize Firebase Admin SDK
            cred = credentials.Certificate(cred_path)
            self._app = firebase_admin.initialize_app(cred, {
                'databaseURL': settings.database_url,
                'projectId': settings.FIREBASE_PROJECT_ID,
            })
            
            print(f"✅ Firebase Admin SDK initialized")
            print(f"   Project: {settings.FIREBASE_PROJECT_ID}")
            print(f"   Environment: {settings.ENV}")
            
            return self._app
            
        except Exception as e:
            print(f"❌ Failed to initialize Firebase: {e}")
            raise
    
    def get_auth(self) -> auth:
        """
        Get Firebase Auth client
        
        Returns:
            firebase_admin.auth: Firebase Auth module
        """
        if not self._app:
            raise RuntimeError("Firebase not initialized. Call initialize() first.")
        return auth
    
    def get_firestore(self) -> firestore.Client:
        """
        Get Firestore client
        
        Returns:
            firestore.Client: Firestore database client
        """
        if not self._app:
            raise RuntimeError("Firebase not initialized. Call initialize() first.")
        
        if not self._db:
            self._db = firestore.client()
        
        return self._db
    
    def is_initialized(self) -> bool:
        """Check if Firebase is initialized"""
        return self._app is not None


# Global instance
firebase_config = FirebaseConfig()
