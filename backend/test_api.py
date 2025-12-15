"""
API Test Script

Quick tests for bizPharma backend API endpoints.
Run this after starting the server with: python main.py
"""

import requests
import json
from datetime import datetime

BASE_URL = "http://localhost:8000"

def print_section(title):
    print(f"\n{'='*60}")
    print(f"  {title}")
    print('='*60)

def test_health():
    """Test health check endpoint"""
    print_section("1. HEALTH CHECK")
    
    response = requests.get(f"{BASE_URL}/health")
    print(f"Status: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    return response.status_code == 200

def test_root():
    """Test root endpoint"""
    print_section("2. ROOT ENDPOINT")
    
    response = requests.get(f"{BASE_URL}/")
    print(f"Status: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    return response.status_code == 200

def test_procurement():
    """Test procurement 3-way matching (without auth for now)"""
    print_section("3. PROCUREMENT - 3-Way Matching")
    
    # Note: This will fail without Firebase auth token
    # Showing structure for reference
    payload = {
        "purchase_order_id": "PO-2024-001",
        "goods_receipt_id": "GRN-2024-005",
        "invoice_id": "INV-SUPPLIER-123"
    }
    
    print("Endpoint: POST /api/v1/procurement/invoices/match")
    print(f"Payload: {json.dumps(payload, indent=2)}")
    print("Note: Requires Firebase authentication token")
    print("  Add header: Authorization: Bearer <firebase-token>")

def test_pricing():
    """Test pricing calculation (without auth)"""
    print_section("4. PRICING - Calculate Price")
    
    payload = {
        "product_id": "PROD-001",
        "customer_id": "CUST-001",
        "location_id": "LOC-MAIN",
        "quantity": 50
    }
    
    print("Endpoint: POST /api/v1/pricing/calculate")
    print(f"Payload: {json.dumps(payload, indent=2)}")
    print("Note: Requires Firebase authentication token")

def test_financial():
    """Test journal entry generation (without auth)"""
    print_section("5. FINANCIAL - Generate Journal Entry")
    
    payload = {
        "transaction_type": "SALE",
        "transaction_id": "TXN-001",
        "amount": 5000.0,
        "description": "Product sale"
    }
    
    print("Endpoint: POST /api/v1/financial/journal-entries/generate")
    print(f"Payload: {json.dumps(payload, indent=2)}")
    print("Note: Requires Firebase authentication token")

def test_inventory():
    """Test FEFO selection (without auth)"""
    print_section("6. INVENTORY - FEFO Batch Selection")
    
    payload = {
        "product_id": "PROD-001",
        "location_id": "LOC-MAIN",
        "quantity_needed": 100
    }
    
    print("Endpoint: POST /api/v1/inventory/batches/fefo-select")
    print(f"Payload: {json.dumps(payload, indent=2)}")
    print("Note: Requires Firebase authentication token")

def main():
    print("\n" + "="*60)
    print("  bizPharma API Test Suite")
    print("="*60)
    print(f"\nBase URL: {BASE_URL}")
    print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    try:
        # Test public endpoints
        health_ok = test_health()
        root_ok = test_root()
        
        # Show authenticated endpoint structures
        test_procurement()
        test_pricing()
        test_financial()
        test_inventory()
        
        print_section("SUMMARY")
        print(f"Health Check: {'✓ PASS' if health_ok else '✗ FAIL'}")
        print(f"Root Endpoint: {'✓ PASS' if root_ok else '✗ FAIL'}")
        print("\nAuthenticated Endpoints: Require Firebase token")
        print("\nNext Steps:")
        print("1. Visit http://localhost:8000/docs for Swagger UI")
        print("2. Get Firebase auth token from Flutter app")
        print("3. Use 'Authorize' button in Swagger to add token")
        print("4. Test all endpoints interactively")
        
    except requests.exceptions.ConnectionError:
        print("\n❌ ERROR: Cannot connect to API server")
        print("   Make sure the server is running:")
        print("   >> cd backend")
        print("   >> python main.py")
    except Exception as e:
        print(f"\n❌ ERROR: {e}")

if __name__ == "__main__":
    main()
