import sys
import os

# Add current directory to path so imports work
sys.path.append(os.getcwd())

print("Attempting to import main app...")
try:
    from main import app
    print("✅ SUCCESS: App imported successfully.")
except Exception as e:
    print(f"❌ FAILURE: App import failed: {e}")
    import traceback
    traceback.print_exc()
