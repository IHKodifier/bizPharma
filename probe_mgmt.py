import httpx
import asyncio
import json

async def probe_mgmt():
    base = "http://127.0.0.1:9399"
    project = "bizpharma-4e73a"
    demo_project = "demo-bizpharma-4e73a"
    locations = ["asia-south1", "us-central1"]
    
    print(f"🔍 Probing Management API at {base}...")
    
    async with httpx.AsyncClient() as client:
        for p in [project, demo_project]:
            for l in locations:
                path = f"/v1beta/projects/{p}/locations/{l}/services"
                url = f"{base}{path}"
                try:
                    resp = await client.get(url)
                    print(f"GET {path} -> {resp.status_code}")
                    if resp.status_code == 200:
                        print(json.dumps(resp.json(), indent=2))
                except Exception as e:
                    print(f"Error {path}: {e}")

if __name__ == "__main__":
    asyncio.run(probe_mgmt())
