"""
Business and Location Schemas
"""

from pydantic import BaseModel, EmailStr, Field
from typing import Optional, List
from datetime import datetime, time


class BusinessProfileBase(BaseModel):
    """Base business profile data"""
    business_name: str
    tax_id: Optional[str] = None
    email: EmailStr
    phone: str
    website: Optional[str] = None
    currency: str = "PKR"
    timezone: str = "Asia/Karachi"


class BusinessProfileUpdate(BusinessProfileBase):
    """Update request for business profile"""
    pass


class SetupInitializeRequest(BaseModel):
    """Initial setup request for new business"""
    business_name: str
    first_name: str
    last_name: str
    phone: str
    email: Optional[EmailStr] = None
    profile_photo: Optional[str] = None


class BusinessProfileResponse(BusinessProfileBase):
    """Response with full business profile"""
    business_id: str
    created_at: datetime
    updated_at: datetime
    status: str = "active"
    subscription_tier: str = "trial"


class OperatingHours(BaseModel):
    """Operating hours for a day"""
    day: str
    open_time: time
    close_time: time
    is_closed: bool = False


class LocationBase(BaseModel):
    """Base location data"""
    name: str
    type: str = Field(..., description="STORE or WAREHOUSE")
    address: str
    city: str
    state: str
    country: str
    phone: Optional[str] = None
    email: Optional[EmailStr] = None
    is_primary: bool = False


class LocationCreate(LocationBase):
    """Create request for location"""
    operating_hours: Optional[List[OperatingHours]] = None


class LocationResponse(LocationBase):
    """Response with full location details"""
    location_id: str
    business_id: str
    created_at: datetime
    active: bool = True


# Supplier Schemas
class SupplierBase(BaseModel):
    """Base supplier data"""
    supplier_name: str
    contact_person: str
    email: EmailStr
    phone: str
    address: Optional[str] = None
    tax_id: Optional[str] = None
    payment_terms: str = "NET30"
    currency: str = "PKR"


class SupplierCreate(SupplierBase):
    """Create request for supplier"""
    pass


class SupplierResponse(SupplierBase):
    """Response with supplier details"""
    supplier_id: str
    business_id: str
    created_at: datetime
    active: bool = True
    rating: float = 0.0


# Product Schemas
class ProductBase(BaseModel):
    """Base product data"""
    name: str
    generic_name: Optional[str] = None
    sku: str
    barcode: Optional[str] = None
    description: Optional[str] = None
    category: str
    uom: str = "UNIT"  # Unit of Measure
    manufacturer: Optional[str] = None
    is_prescription_required: bool = False
    tax_rate: float = 0.0


class ProductCreate(ProductBase):
    """Create request for product"""
    cost_price: float
    selling_price: float
    initial_stock: int = 0
    reorder_level: int = 10


class ProductResponse(ProductBase):
    """Response with product details"""
    product_id: str
    business_id: str
    cost_price: float
    selling_price: float
    current_stock: int
    created_at: datetime
    active: bool = True
