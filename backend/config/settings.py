from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    """Application configuration settings"""
    
    # Application
    APP_NAME: str = "bizPharma API"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = True
    
    # Firebase
    FIREBASE_PROJECT_ID: str = "bizpharma-prod"
    FIREBASE_DATABASE_URL: str = "https://bizpharma-prod.firebaseio.com"
    FIREBASE_CREDENTIALS_PATH: str = "./serviceAccountKey.json"
    
    # Data Connect
    DATA_CONNECT_ENDPOINT: str = "https://dataconnect.googleapis.com"
    DATA_CONNECT_PROJECT_ID: str = "bizpharma-prod"
    DATA_CONNECT_LOCATION: str = "asia-south1"
    DATA_CONNECT_SERVICE: str = "biz-pharma"
    
    # Security
    SECRET_KEY: str
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


settings = Settings()
