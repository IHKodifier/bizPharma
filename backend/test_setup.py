"""
Test script to verify backend setup

Run this to verify that the backend is configured correctly Before starting the server.
"""

print("Testing bizPharma Backend Setup...")
print("=" * 50)

# Test 1: Import packages
print("\n1️⃣  Testing package imports...")
try:
    import fastapi
    import uvicorn
    import firebase_admin
    import pydantic_settings
    print("   ✅ All packages installed correctly")
except ImportError as e:
    print(f"   ❌ Import error: {e}")
    exit(1)

# Test 2: Check directory structure
print("\n2️⃣  Testing directory structure...")
import os
required_dirs = ["config", "core", "modules", "shared", "tests"]
for dir_name in required_dirs:
    if os.path.exists(dir_name):
        print(f"   ✅ {dir_name}/ exists")
    else:
        print(f"   ❌ {dir_name}/ missing")

# Test 3: Check required files
print("\n3️⃣  Testing required files...")
required_files = [
    "main.py",
    "config/settings.py",
    ".env.example",
    ".gitignore",
    "requirements.txt",
]
for file_name in required_files:
    if os.path.exists(file_name):
        print(f"   ✅ {file_name} exists")
    else:
        print(f"   ❌ {file_name} missing")

# Test 4: Check .env file
print("\n4️⃣  Checking environment configuration...")
if os.path.exists(".env"):
    print("   ✅ .env file found")
    print("   ⚠️  Remember to update SECRET_KEY in production!")
else:
    print("   ❌ .env file not found")
    print("   📝 Create .env from .env.example:")
    print("      cp .env.example .env")
    print("      # Then edit .env with your values")

print("\n" + "=" * 50)
print("✨ Setup verification complete!\n")
print("Next steps:")
print("1. Create .env file if not exists: cp .env.example .env")
print("2. Add Firebase service account key: serviceAccountKey.json")
print("3. Run server: python main.py")
print("4. Visit: http://localhost:8000/docs")
