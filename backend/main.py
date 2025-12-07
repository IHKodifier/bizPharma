"""
bizPharma FastAPI Application

Main entry point for the bizPharma backend API server.
"""

from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

from config.settings import settings
from config.firebase_config import firebase_config
from core.security import get_current_user, get_optional_user


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan events"""
    #Startup
    print("Starting bizPharma API...")
    print(f"App: {settings.APP_NAME} v{settings.APP_VERSION}")
    print(f"Debug mode: {settings.DEBUG}")
    print(f"Firebase Project: {settings.FIREBASE_PROJECT_ID}")
    
    # Initialize Firebase Admin SDK
    try:
        firebase_config.initialize()
        print("Firebase Admin SDK initialized successfully")
    except FileNotFoundError:
        print("WARNING: Firebase service account key not found")
        print("   Server will start but Firebase features won't work")
        print("   See README.md for setup instructions")
    except Exception as e:
        print(f"WARNING: Firebase initialization failed: {e}")
    
    print("bizPharma API ready!")
    
    yield
    
    # Shutdown
    print("Shutting down bizPharma API...")


app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    description="bizPharma - Modular Pharmacy Management System API",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan,
)

# CORS Configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # IMPORTANT: Configure properly in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    """Root endpoint - API information"""
    return {
        "app": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "status": "running",
        "docs": "/docs",
        "firebase_initialized": firebase_config.is_initialized(),
    }


@app.get("/health")
async def health_check():
    """Health check endpoint for monitoring"""
    return {
        "status": "healthy",
        "app": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "firebase": "initialized" if firebase_config.is_initialized() else "not initialized",
    }


@app.get("/api/v1/me")
async def get_current_user_info(current_user: dict = Depends(get_current_user)):
    """
    Get current authenticated user information
    
    Requires: Valid Firebase ID token in Authorization header
    """
    return {
        "user": current_user,
        "message": "Successfully authenticated!",
    }


@app.get("/api/v1/public")
async def public_endpoint(user: dict = Depends(get_optional_user)):
    """
    Public endpoint that works with or without authentication
    
    If authenticated, returns user info. Otherwise returns public message.
    """
    if user:
        return {
            "message": "Welcome back!",
            "user": user,
            "authenticated": True,
        }
    else:
        return {
            "message": "Welcome to bizPharma API",
            "authenticated": False,
        }


# Register module routers
from modules.auth.router import router as auth_router
from modules.setup.router import router as setup_router
from modules.procurement.router import router as procurement_router
from modules.pricing.router import router as pricing_router
from modules.financial.router import router as financial_router
from modules.inventory.router import router as inventory_router

app.include_router(auth_router, prefix="/api/v1/auth", tags=["Authentication"])
app.include_router(setup_router, prefix="/api/v1/setup", tags=["Setup"])
app.include_router(procurement_router, prefix="/api/v1/procurement", tags=["Procurement"])
app.include_router(pricing_router, prefix="/api/v1/pricing", tags=["Pricing"])
app.include_router(financial_router, prefix="/api/v1/financial", tags=["Financial"])
app.include_router(inventory_router, prefix="/api/v1/inventory", tags=["Inventory"])


if __name__ == "__main__":
    import uvicorn
    
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True if settings.DEBUG else False,
        log_level="info",
    )
