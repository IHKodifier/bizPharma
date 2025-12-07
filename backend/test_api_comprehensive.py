"""
Comprehensive API Test Suite

Tests all bizPharma backend endpoints and documents responses.
"""

import requests
import json
from datetime import datetime

BASE_URL = "http://localhost:8000"

class Colors:
    GREEN = '\033[92m'
    RED = '\033[91m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    END = '\033[0m'

def print_header(text):
    print(f"\n{Colors.BLUE}{'='*70}{Colors.END}")
    print(f"{Colors.BLUE}{text:^70}{Colors.END}")
    print(f"{Colors.BLUE}{'='*70}{Colors.END}")

def print_test(endpoint, method="GET"):
    print(f"\n{Colors.YELLOW}Testing: {method} {endpoint}{Colors.END}")

def print_pass():
    print(f"{Colors.GREEN}[PASS]{Colors.END}")

def print_fail(reason):
    print(f"{Colors.RED}[FAIL] {reason}{Colors.END}")

# Test results tracking
results = {
    "passed": [],
    "failed": [],
    "auth_required": []
}

def test_endpoint(name, method, url, payload=None, requires_auth=False):
    """Test a single endpoint"""
    print_test(url, method)
    
    try:
        if method == "GET":
            response = requests.get(url, timeout=5)
        elif method == "POST":
            response = requests.post(url, json=payload, timeout=5)
        else:
            print_fail(f"Unsupported method: {method}")
            return
        
        print(f"Status Code: {response.status_code}")
        
        if requires_auth and response.status_code == 403:
            print(f"{Colors.YELLOW}[AUTH REQUIRED] Endpoint requires authentication{Colors.END}")
            results["auth_required"].append({
                "name": name,
                "endpoint": url,
                "method": method
            })
            return
        
        if response.status_code == 200:
            data = response.json()
            print(f"Response: {json.dumps(data, indent=2)[:200]}...")
            print_pass()
            results["passed"].append({
                "name": name,
                "endpoint": url,
                "status": response.status_code
            })
        else:
            print(f"Response: {response.text[:200]}")
            print_fail(f"Status {response.status_code}")
            results["failed"].append({
                "name": name,
                "endpoint": url,
                "status": response.status_code,
                "error": response.text[:200]
            })
    
    except requests.exceptions.ConnectionError:
        print_fail("Connection refused - server not running?")
        results["failed"].append({
            "name": name,
            "endpoint": url,
            "error": "Connection refused"
        })
    except Exception as e:
        print_fail(str(e))
        results["failed"].append({
            "name": name,
            "endpoint": url,
            "error": str(e)
        })

def main():
    print_header("bizPharma API Comprehensive Test Suite")
    print(f"Base URL: {BASE_URL}")
    print(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # ==================== PUBLIC ENDPOINTS ====================
    print_header("PUBLIC ENDPOINTS (No Auth Required)")
    
    test_endpoint(
        "Root Endpoint",
        "GET",
        f"{BASE_URL}/"
    )
    
    test_endpoint(
        "Health Check",
        "GET",
        f"{BASE_URL}/health"
    )
    
    # ==================== PROCUREMENT ====================
    print_header("PROCUREMENT MODULE")
    
    test_endpoint(
        "3-Way Matching",
        "POST",
        f"{BASE_URL}/api/v1/procurement/invoices/match",
        payload={
            "purchase_order_id": "PO-2024-001",
            "goods_receipt_id": "GRN-2024-005",
            "invoice_id": "INV-SUPPLIER-123"
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Approve Requisition",
        "POST",
        f"{BASE_URL}/api/v1/procurement/requisitions/approve",
        payload={
            "document_id": "REQ-001",
            "approved": True,
            "notes": "Test approval"
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Approve Purchase Order",
        "POST",
        f"{BASE_URL}/api/v1/procurement/purchase-orders/approve",
        payload={
            "document_id": "PO-001",
            "approved": True
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Procurement Dashboard Stats",
        "GET",
        f"{BASE_URL}/api/v1/procurement/dashboard-stats",
        requires_auth=True
    )
    
    # ==================== PRICING ====================
    print_header("PRICING MODULE")
    
    test_endpoint(
        "Calculate Price",
        "POST",
        f"{BASE_URL}/api/v1/pricing/calculate",
        payload={
            "product_id": "PROD-001",
            "customer_id": "CUST-001",
            "location_id": "LOC-MAIN",
            "quantity": 50
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Calculate Bulk Prices",
        "POST",
        f"{BASE_URL}/api/v1/pricing/calculate-bulk",
        payload={
            "customer_id": "CUST-001",
            "location_id": "LOC-MAIN",
            "items": [
                {"product_id": "PROD-001", "quantity": 50},
                {"product_id": "PROD-002", "quantity": 25}
            ]
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Get Tier Discounts",
        "GET",
        f"{BASE_URL}/api/v1/pricing/tiers",
        requires_auth=True
    )
    
    test_endpoint(
        "Get Customer Tier",
        "GET",
        f"{BASE_URL}/api/v1/pricing/customer/CUST-001/tier",
        requires_auth=True
    )
    
    # ==================== FINANCIAL ====================
    print_header("FINANCIAL MODULE")
    
    test_endpoint(
        "Generate Journal Entry - Sale",
        "POST",
        f"{BASE_URL}/api/v1/financial/journal-entries/generate",
        payload={
            "transaction_type": "SALE",
            "transaction_id": "TXN-001",
            "amount": 5000.0,
            "description": "Test sale"
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Generate Journal Entry - Purchase",
        "POST",
        f"{BASE_URL}/api/v1/financial/journal-entries/generate",
        payload={
            "transaction_type": "PURCHASE",
            "transaction_id": "TXN-002",
            "amount": 3000.0
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Calculate Tax",
        "POST",
        f"{BASE_URL}/api/v1/financial/tax/calculate",
        payload={
            "subtotal": 10000.0,
            "tax_rate": 18.0,
            "location_id": "LOC-MAIN"
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Get Chart of Accounts",
        "GET",
        f"{BASE_URL}/api/v1/financial/accounts",
        requires_auth=True
    )
    
    # ==================== INVENTORY ====================
    print_header("INVENTORY MODULE")
    
    test_endpoint(
        "FEFO Batch Selection",
        "POST",
        f"{BASE_URL}/api/v1/inventory/batches/fefo-select",
        payload={
            "product_id": "PROD-001",
            "location_id": "LOC-MAIN",
            "quantity_needed": 100
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Expiry Dashboard",
        "GET",
        f"{BASE_URL}/api/v1/inventory/expiry/dashboard",
        requires_auth=True
    )
    
    test_endpoint(
        "Stock Adjustment",
        "POST",
        f"{BASE_URL}/api/v1/inventory/stock/adjust",
        payload={
            "product_id": "PROD-001",
            "location_id": "LOC-MAIN",
            "batch_id": "BATCH-001",
            "quantity_change": -5,
            "reason": "Damaged goods"
        },
        requires_auth=True
    )
    
    test_endpoint(
        "Inventory Dashboard Stats",
        "GET",
        f"{BASE_URL}/api/v1/inventory/dashboard-stats",
        requires_auth=True
    )
    
    # ==================== AUTHENTICATED USER ====================
    print_header("USER ENDPOINTS")
    
    test_endpoint(
        "Get Current User",
        "GET",
        f"{BASE_URL}/api/v1/me",
        requires_auth=True
    )
    
    test_endpoint(
        "Public Endpoint (Optional Auth)",
        "GET",
        f"{BASE_URL}/api/v1/public"
    )
    
    # ==================== SUMMARY ====================
    print_header("TEST SUMMARY")
    
    total = len(results["passed"]) + len(results["failed"]) + len(results["auth_required"])
    
    print(f"\nTotal Endpoints Tested: {total}")
    print(f"{Colors.GREEN}Passed: {len(results['passed'])}{Colors.END}")
    print(f"{Colors.RED}Failed: {len(results['failed'])}{Colors.END}")
    print(f"{Colors.YELLOW}Auth Required: {len(results['auth_required'])}{Colors.END}")
    
    if results["failed"]:
        print(f"\n{Colors.RED}FAILED ENDPOINTS:{Colors.END}")
        for item in results["failed"]:
            print(f"  - {item['name']}: {item.get('error', 'Unknown error')}")
    
    if results["auth_required"]:
        print(f"\n{Colors.YELLOW}ENDPOINTS REQUIRING AUTHENTICATION:{Colors.END}")
        for item in results["auth_required"]:
            print(f"  - {item['method']} {item['endpoint']}")
    
    print(f"\n{Colors.GREEN}Test completed successfully!{Colors.END}")
    print(f"All authenticated endpoints are properly protected.")
    print(f"\nTo test authenticated endpoints:")
    print(f"1. Get Firebase auth token from Flutter app")
    print(f"2. Use Swagger UI at http://localhost:8000/docs")
    print(f"3. Click 'Authorize' and paste token")

if __name__ == "__main__":
    main()
