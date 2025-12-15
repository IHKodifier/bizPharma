from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    """Application configuration settings"""
    
    # Application
    APP_NAME: str = "bizPharma API"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = True
    
    # Firebase
    FIREBASE_PROJECT_ID: str = "bizpharma-4e73a"
    FIREBASE_DATABASE_URL: str = "https://bizpharma-4e73a.firebaseio.com"
    FIREBASE_CREDENTIALS_PATH: str = "./serviceAccountKey.json"
    
    # Data Connect
    DATA_CONNECT_ENDPOINT: str = "http://127.0.0.1:9399"
    DATA_CONNECT_PROJECT_ID: str = "bizpharma-4e73a"
    DATA_CONNECT_LOCATION: str = "asia-south1"
    DATA_CONNECT_SERVICE: str = "bizpharma-service"
    DATA_CONNECT_CONNECTOR: str = "biz-pharma"
    
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
