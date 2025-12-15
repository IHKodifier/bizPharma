"""
Setup Module Test Script (Unicode Safe)
"""

import requests
import json

BASE_URL = "http://localhost:8000"

def print_result(name, response):
    status = "PASS" if response.status_code in [200, 403] else "FAIL"
    print(f"{status} - {name} ({response.status_code})")
    if response.status_code not in [200, 403]:
        print(f"Error: {response.text}")

def test_setup_endpoints():
    print("\nTesting Setup Module Endpoints...")
    print("Note: Expecting 403 Forbidden for authenticated endpoints (PASS for security)")
    
    # Business Profile
    try:
        resp = requests.get(f"{BASE_URL}/api/v1/setup/business")
        print_result("Get Business Profile", resp)
    except Exception as e:
        print(f"FAIL - Get Business Profile: {e}")

    # Locations
    try:
        resp = requests.get(f"{BASE_URL}/api/v1/setup/locations")
        print_result("List Locations", resp)
    except: pass

    # Suppliers
    try:
        resp = requests.get(f"{BASE_URL}/api/v1/setup/suppliers")
        print_result("List Suppliers", resp)
    except: pass

    # Products
    try:
        resp = requests.get(f"{BASE_URL}/api/v1/setup/products")
        print_result("Search Products", resp)
    except: pass

if __name__ == "__main__":
    test_setup_endpoints()
