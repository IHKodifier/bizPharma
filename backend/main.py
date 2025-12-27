"""
bizPharma FastAPI Application

Main entry point for the bizPharma backend API server.
"""

import logging
import json
import time
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request, Response, Depends
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware

from config.settings import settings
from config.firebase_config import firebase_config
from core.security import get_current_user, get_optional_user

# --- Verbose Logging Configuration ---
logging.basicConfig(
    level=settings.LOG_LEVEL,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
)
logger = logging.getLogger("bizPharma")

class RequestResponseLoggingMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        # Log Request
        # we read the body here to log it
        request_body = await request.body()
        logger.debug(f"Incoming Request: {request.method} {request.url}")
        if request_body:
            try:
                body_json = json.loads(request_body)
                logger.debug(f"Request Body: {json.dumps(body_json, indent=2)}")
            except:
                logger.debug(f"Request Body (raw): {request_body.decode(errors='ignore')}")

        # CRITICAL FIX: The call to request.body() consumes the stream.
        # We must re-create the receive channel so subsequent handlers (like FastAPI validation)
        # can read the body again.
        async def receive():
            return {"type": "http.request", "body": request_body, "more_body": False}
        request._receive = receive

        start_time = time.time()
        response = await call_next(request)
        process_time = (time.time() - start_time) * 1000

        # Log Response
        logger.debug(f"Response Status: {response.status_code} (took {process_time:.2f}ms)")
        return response

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan events"""
    
    # --- Service Readiness Report ---
    print("\n" + "="*50)
    print("      🚀 BIZPHARMA SERVICE READINESS REPORT      ")
    print("="*50)
    print(f" ENVIRONMENT        : {settings.ENV}")
    print(f" PROJECT ID         : {settings.FIREBASE_PROJECT_ID}")
    print(f" DC SERVICE         : {settings.DATA_CONNECT_SERVICE}")
    print(f" DC CONNECTOR       : {settings.DATA_CONNECT_CONNECTOR}")
    print(f" DC ENDPOINT        : {settings.DATA_CONNECT_ENDPOINT}")
    print(f" AUTH EMULATOR      : {settings.FIREBASE_AUTH_EMULATOR_HOST or 'OFF'}")
    print("="*50 + "\n")

    # Initialize Firebase Admin SDK
    try:
        firebase_config.initialize()
        print("✅ Firebase Admin SDK initialized successfully")
    except Exception as e:
        print(f"❌ Firebase initialization failed: {e}")
    
    print("bizPharma API ready!\n")
    
    yield
    print("Shutting down bizPharma API...")

app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    description="bizPharma - Modular Pharmacy Management System API",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan,
)

# --- CORS Configuration ---
app.add_middleware(
    CORSMiddleware,
    # Allow specific origins for Staging/Prod/Dev
    allow_origins=[
        "https://bizpharma-staging.web.app",
        "https://bizpharma-prod.web.app",
        "http://localhost:3000",
        "http://127.0.0.1:3000",
        "http://localhost:8000",
        # Add your custom domains here when ready
        "https://api.bizpharma.app",
        "https://api-staging.bizpharma.app",
        "https://bizpharma.app",
        "https://www.bizpharma.app",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Middleware
app.add_middleware(RequestResponseLoggingMiddleware)


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
