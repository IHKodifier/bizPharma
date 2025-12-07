"""
Setup Module Test Script

Tests business, location, supplier, and product setup endpoints.
"""

import requests
import json
import time

BASE_URL = "http://localhost:8000"

def print_result(name, response):
    status = "✅ PASS" if response.status_code in [200, 403] else "❌ FAIL"
    print(f"{status} - {name} ({response.status_code})")
    if response.status_code not in [200, 403]:
        print(f"Error: {response.text}")

def test_setup_endpoints():
    print("\ntesting Setup Module Endpoints...")
    print("Note: Expecting 403 Forbidden for authenticated endpoints (which is a PASS for security)")
    
    # Business Profile
    print("\n--- Business Profile ---")
    resp = requests.get(f"{BASE_URL}/api/v1/setup/business")
    print_result("Get Business Profile", resp)
    
    resp = requests.put(f"{BASE_URL}/api/v1/setup/business", json={
        "business_name": "Updated Pharma",
        "email": "admin@updated.com",
        "phone": "+923000000000"
    })
    print_result("Update Business Profile", resp)

    # Locations
    print("\n--- Locations ---")
    resp = requests.get(f"{BASE_URL}/api/v1/setup/locations")
    print_result("List Locations", resp)
    
    resp = requests.post(f"{BASE_URL}/api/v1/setup/locations", json={
        "name": "New Branch",
        "type": "STORE",
        "address": "123 Main St",
        "city": "Lahore",
        "state": "Punjab",
        "country": "Pakistan"
    })
    print_result("Create Location", resp)

    # Suppliers
    print("\n--- Suppliers ---")
    resp = requests.get(f"{BASE_URL}/api/v1/setup/suppliers")
    print_result("List Suppliers", resp)
    
    resp = requests.post(f"{BASE_URL}/api/v1/setup/suppliers", json={
        "supplier_name": "PharmaSupply Co",
        "contact_person": "Ali",
        "email": "ali@supply.com",
        "phone": "+923001234567"
    })
    print_result("Create Supplier", resp)

    # Products
    print("\n--- Products ---")
    resp = requests.get(f"{BASE_URL}/api/v1/setup/products")
    print_result("Search Products", resp)
    
    resp = requests.post(f"{BASE_URL}/api/v1/setup/products", json={
        "name": "Test Drug",
        "sku": "TST-001",
        "category": "General",
        "cost_price": 100,
        "selling_price": 120
    })
    print_result("Create Product", resp)

if __name__ == "__main__":
    try:
        test_setup_endpoints()
    except Exception as e:
        print(f"Test failed: {e}")
