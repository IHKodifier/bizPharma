"""
Pricing Engine

Calculates customer-specific pricing based on:
- Customer tier (Platinum, Gold, Silver, Bronze, Regular)
- Custom price overrides
- Volume discounts
- Promotional discounts
- Base pricing
"""

from typing import Optional, Dict
from decimal import Decimal
from datetime import datetime

from .schemas import (
    PriceCalculationResponse,
    PricingRule,
    CustomerTier
)


class PricingEngine:
    """
    Dynamic pricing engine with tier-based and rule-based pricing
    
    Priority hierarchy:
    1. Customer-specific override (highest)
    2. Tier-specific pricing
    3. Volume discount
    4. Promotional discount
    5. Base price (lowest)
    """
    
    # Tier discount percentages
    TIER_DISCOUNTS = {
        CustomerTier.PLATINUM: 15.0,  # 15% discount
        CustomerTier.GOLD: 10.0,      # 10% discount
        CustomerTier.SILVER: 5.0,     # 5% discount
        CustomerTier.BRONZE: 2.0,     # 2% discount
        CustomerTier.REGULAR: 0.0,    # No discount
    }
    
    async def calculate_price(
        self,
        product_id: str,
        customer_id: str,
        location_id: str,
        quantity: int = 1
    ) -> PriceCalculationResponse:
        """
        Calculate final price for customer
        
        Args:
            product_id: Product ID
            customer_id: Customer ID
            location_id: Location/store ID
            quantity: Quantity to purchase
            
        Returns:
            PriceCalculationResponse with pricing breakdown
        """
        
        # TODO: Fetch actual data from Firebase Data Connect
        # Mock data for demonstration
        
        # Get base price from database
        base_price = await self._get_base_price(product_id, location_id)
        
        # Get customer tier
        customer_tier = await self._get_customer_tier(customer_id)
        
        # Priority 1: Check for customer-specific override
        custom_price = await self._get_custom_price(product_id, customer_id)
        if custom_price:
            final_price = custom_price
            discount_pct = ((base_price - custom_price) / base_price) * 100
            
            return self._build_response(
                product_id=product_id,
                customer_id=customer_id,
                quantity=quantity,
                base_price=base_price,
                final_price=final_price,
                pricing_rule=PricingRule.CUSTOMER_OVERRIDE,
                discount_percentage=discount_pct,
                customer_tier=customer_tier
            )
        
        # Priority 2: Check tier pricing
        tier_discount = self.TIER_DISCOUNTS.get(customer_tier, 0.0)
        if tier_discount > 0:
            final_price = base_price * (1 - tier_discount / 100)
            
            return self._build_response(
                product_id=product_id,
                customer_id=customer_id,
                quantity=quantity,
                base_price=base_price,
                final_price=final_price,
                pricing_rule=PricingRule.TIER_PRICING,
                discount_percentage=tier_discount,
                customer_tier=customer_tier
            )
        
        # Priority 3: Check volume discount
        volume_discount = await self._get_volume_discount(product_id, quantity)
        
        # Priority 4: Check promotional discount
        promo_discount = await self._get_promotional_discount(product_id, location_id)
        
        # Apply best discount
        best_discount = max(volume_discount, promo_discount)
        
        if best_discount > 0:
            final_price = base_price * (1 - best_discount / 100)
            pricing_rule = (
                PricingRule.VOLUME_DISCOUNT 
                if volume_discount > promo_discount 
                else PricingRule.PROMOTIONAL_DISCOUNT
            )
            
            return self._build_response(
                product_id=product_id,
                customer_id=customer_id,
                quantity=quantity,
                base_price=base_price,
                final_price=final_price,
                pricing_rule=pricing_rule,
                discount_percentage=best_discount,
                customer_tier=customer_tier
            )
        
        # Priority 5: Base price (no discounts)
        return self._build_response(
            product_id=product_id,
            customer_id=customer_id,
            quantity=quantity,
            base_price=base_price,
            final_price=base_price,
            pricing_rule=PricingRule.BASE_PRICE,
            discount_percentage=0.0,
            customer_tier=customer_tier
        )
    
    async def _get_base_price(
        self,
        product_id: str,
        location_id: str
    ) -> float:
        """Get base price for product at location"""
        # TODO: Query ProductPricing table via Firebase Data Connect
        # Mock data
        mock_prices = {
            "PROD-001": 100.0,
            "PROD-002": 250.0,
            "PROD-003": 75.0,
        }
        return mock_prices.get(product_id, 100.0)
    
    async def _get_customer_tier(self, customer_id: str) -> CustomerTier:
        """Get customer tier classification"""
        # TODO: Query Customer table
        # Mock data
        mock_tiers = {
            "CUST-001": CustomerTier.PLATINUM,
            "CUST-002": CustomerTier.GOLD,
            "CUST-003": CustomerTier.SILVER,
        }
        return mock_tiers.get(customer_id, CustomerTier.REGULAR)
    
    async def _get_custom_price(
        self,
        product_id: str,
        customer_id: str
    ) -> Optional[float]:
        """Check for customer-specific price override"""
        # TODO: Query ProductPricing table for customer_id override
        # Return None if no override exists
        return None
    
    async def _get_volume_discount(
        self,
        product_id: str,
        quantity: int
    ) -> float:
        """Calculate volume discount percentage based on quantity"""
        # TODO: Query VolumeDiscount table
        # Mock volume discount rules
        if quantity >= 100:
            return 10.0  # 10% for 100+ units
        elif quantity >= 50:
            return 5.0   # 5% for 50+ units
        elif quantity >= 20:
            return 2.0   # 2% for 20+ units
        return 0.0
    
    async def _get_promotional_discount(
        self,
        product_id: str,
        location_id: str
    ) -> float:
        """Get active promotional discount for product"""
        # TODO: Query PromotionalDiscount table
        # Check valid_from and valid_to dates
        # Mock: No active promotions
        return 0.0
    
    def _build_response(
        self,
        product_id: str,
        customer_id: str,
        quantity: int,
        base_price: float,
        final_price: float,
        pricing_rule: PricingRule,
        discount_percentage: float,
        customer_tier: CustomerTier
    ) -> PriceCalculationResponse:
        """Build price calculation response"""
        
        total_amount = final_price * quantity
        base_total = base_price * quantity
        savings = base_total - total_amount
        discount_amount = base_price - final_price
        
        return PriceCalculationResponse(
            product_id=product_id,
            customer_id=customer_id,
            quantity=quantity,
            base_price=base_price,
            final_price=final_price,
            total_amount=total_amount,
            pricing_rule=pricing_rule,
            discount_percentage=discount_percentage if discount_percentage > 0 else None,
            discount_amount=discount_amount if discount_amount > 0 else None,
            customer_tier=customer_tier,
            savings=savings
        )
