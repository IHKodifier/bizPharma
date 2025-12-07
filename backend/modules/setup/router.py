"""
Setup Router

FastAPI endpoints for initial business setup.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from typing import List, Dict

from core.security import get_current_user, require_permissions
from ..schemas import (
    BusinessProfileUpdate,
    BusinessProfileResponse,
    LocationCreate,
    LocationResponse
)
from .business.service import BusinessService
from .locations.service import LocationService


router = APIRouter()
business_service = BusinessService()
location_service = LocationService()

# Initialization Endpoint
from ..schemas import SetupInitializeRequest
from .initialization import initialize_business

@router.post("/initialize", response_model=BusinessProfileResponse)
async def setup_initialization(
    data: SetupInitializeRequest,
    current_user: Dict = Depends(get_current_user)
):
    """
    Initialize business for the first time.
    Sets 'business_id' custom claim on the user.
    """
    return await initialize_business(current_user['uid'], data)


# Business Profile Endpoints
@router.get("/business", response_model=BusinessProfileResponse)
async def get_business_profile(
    current_user: Dict = Depends(get_current_user)
):
    """Get current business profile"""
    business_id = current_user.get("business_id")
    if not business_id:
        raise HTTPException(400, "User not associated with a business")
        
    return await business_service.get_profile(business_id)


@router.put("/business", response_model=BusinessProfileResponse)
async def update_business_profile(
    data: BusinessProfileUpdate,
    current_user: Dict = Depends(require_permissions("setup:business"))
):
    """Update business profile"""
    business_id = current_user.get("business_id")
    return await business_service.update_profile(business_id, data)


# Location Endpoints
@router.post("/locations", response_model=LocationResponse)
async def create_location(
    data: LocationCreate,
    current_user: Dict = Depends(require_permissions("setup:locations"))
):
    """Create new business location (store/warehouse)"""
    business_id = current_user.get("business_id")
    return await location_service.create_location(business_id, data)


@router.get("/locations", response_model=List[LocationResponse])
async def get_locations(
    current_user: Dict = Depends(get_current_user)
):
    """List all business locations"""
    business_id = current_user.get("business_id")
    return await location_service.get_locations(business_id)


# Supplier Endpoints
from .suppliers.service import SupplierService
from ..schemas import SupplierCreate, SupplierResponse

supplier_service = SupplierService()

@router.post("/suppliers", response_model=SupplierResponse)
async def create_supplier(
    data: SupplierCreate,
    current_user: Dict = Depends(require_permissions("setup:suppliers"))
):
    """Create new supplier"""
    business_id = current_user.get("business_id")
    return await supplier_service.create_supplier(business_id, data)


@router.get("/suppliers", response_model=List[SupplierResponse])
async def get_suppliers(
    current_user: Dict = Depends(get_current_user)
):
    """List all suppliers"""
    business_id = current_user.get("business_id")
    return await supplier_service.get_suppliers(business_id)


# Product Endpoints
from .products.service import ProductService
from ..schemas import ProductCreate, ProductResponse

product_service = ProductService()

@router.post("/products", response_model=ProductResponse)
async def create_product(
    data: ProductCreate,
    current_user: Dict = Depends(require_permissions("setup:products"))
):
    """Create new product in catalog"""
    business_id = current_user.get("business_id")
    return await product_service.create_product(business_id, data)


@router.get("/products", response_model=List[ProductResponse])
async def search_products(
    query: Optional[str] = None,
    current_user: Dict = Depends(get_current_user)
):
    """Search product catalog"""
    business_id = current_user.get("business_id")
    return await product_service.search_products(business_id, query)
