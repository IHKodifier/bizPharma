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
            print("📝 To get your service account key:")
            print("   1. Go to Firebase Console → Project Settings")
            print("   2. Click 'Service Accounts' tab")
            print("   3. Click 'Generate New Private Key'")
            print(f"   4. Save as '{cred_path}'")
            raise FileNotFoundError(
                f"Firebase service account key not found at {cred_path}"
            )
        
        try:
            # Initialize Firebase Admin SDK
            cred = credentials.Certificate(cred_path)
            self._app = firebase_admin.initialize_app(cred, {
                'databaseURL': settings.FIREBASE_DATABASE_URL,
                'projectId': settings.FIREBASE_PROJECT_ID,
            })
            
            print(f"✅ Firebase Admin SDK initialized")
            print(f"   Project: {settings.FIREBASE_PROJECT_ID}")
            
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
