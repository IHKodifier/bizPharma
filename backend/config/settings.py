from pydantic_settings import BaseSettings
from typing import Optional, Literal
import os


class Settings(BaseSettings):
    """Application configuration settings"""
    
    # Application
    APP_NAME: str = "bizPharma API"
    APP_VERSION: str = "1.0.0"
    
    # Environment: DEV, STAGING, or PROD
    # Default is DEV for safety. Change via .env or OS environment variable.
    ENV: Literal["DEV", "STAGING", "PROD"] = "DEV"
    DEBUG: bool = True  # Usually True for DEV

    # --- Project Identifiers ---
    # These can be overridden in .env if the project name changes
    DEV_PROJECT_ID: str = "bizpharma-4e73a"
    STAGING_PROJECT_ID: str = "bizpharma-staging"
    PROD_PROJECT_ID: str = "bizpharma-prod"

    # --- Environment Awareness (Locked) ---
    @property
    def FIREBASE_PROJECT_ID(self) -> str:
        """Environment-aware Project ID"""
        if self.ENV == "PROD":
            return self.PROD_PROJECT_ID
        elif self.ENV == "STAGING":
            return self.STAGING_PROJECT_ID
        return self.DEV_PROJECT_ID

    @property
    def DATA_CONNECT_SERVICE(self) -> str:
        """Force locked service ID based on dataconnect.yaml"""
        return "bizpharma-service"

    @property
    def DATA_CONNECT_CONNECTOR(self) -> str:
        """Force locked connector ID based on connector.yaml"""
        return "biz-pharma"

    DATA_CONNECT_LOCATION: str = "asia-south1"

    @property
    def DATA_CONNECT_ENDPOINT(self) -> str:
        if self.ENV == "DEV":
            return "http://127.0.0.1:9399"
        return "https://dataconnect.googleapis.com"
    
    @property
    def DATA_CONNECT_PROJECT_ID(self) -> str:
        return self.FIREBASE_PROJECT_ID

    # Logging
    LOG_LEVEL: str = "DEBUG"

    # --- Firebase Admin SDK ---
    FIREBASE_DATABASE_URL: Optional[str] = None
    FIREBASE_CREDENTIALS_PATH: str = "./serviceAccountKey.json"
    FIREBASE_AUTH_EMULATOR_HOST: Optional[str] = "127.0.0.1:9099"

    @property
    def database_url(self) -> str:
        if self.FIREBASE_DATABASE_URL:
            return self.FIREBASE_DATABASE_URL
        return f"https://{self.FIREBASE_PROJECT_ID}.firebaseio.com" 
        

    # --- Security ---
    SECRET_KEY: str = "temporary-secret-key-change-this"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # External Services (Optional)
    WHATSAPP_API_KEY: Optional[str] = None
    WHATSAPP_PHONE_NUMBER_ID: Optional[str] = None
    PADDLE_VENDOR_ID: Optional[str] = None
    PADDLE_API_KEY: Optional[str] = None
    
    # ML Configuration
    ML_MODELS_PATH: str = "./models"
    ENABLE_AI_FEATURES: bool = True
    
    class Config:
        env_file = ".env"
        case_sensitive = True
        extra = "ignore"


settings = Settings()
