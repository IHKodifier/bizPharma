import httpx
import asyncio

async def probe():
    base = "http://127.0.0.1:9399"
    project = "bizpharma-4e73a"
    demo_project = "demo-bizpharma-4e73a"
    locations = ["asia-south1", "us-central1"]
    service = "bizpharma-service"
    connector = "biz-pharma"
    
    paths = []
    for loc in locations:
        paths.append(f"/v1beta/projects/{project}/locations/{loc}/services/{service}/connectors/{connector}:executeGraphql")
        # paths.append(f"/v1beta/projects/{demo_project}/locations/{loc}/services/{service}/connectors/{connector}:executeGraphql")
    
    print(f"🔍 Probing Data Connect Emulator at {base}...")
    
    async with httpx.AsyncClient() as client:
        for path in paths:
            url = f"{base}{path}"
            try:
                # Try GET first
                resp = await client.get(url)
                print(f"GET {path} -> {resp.status_code}")
                if resp.status_code != 404:
                    print(f"   Response: {resp.text[:200]}")
                    
                # Try POST (for graphql endpoints)
                resp = await client.post(url, json={"query": "{ __typename }", "operationName": "Test"})
                print(f"POST {path} -> {resp.status_code}")
                if resp.status_code != 404:
                    print(f"   Response: {resp.text[:200]}")
                    
            except Exception as e:
                print(f"Error {path}: {e}")

if __name__ == "__main__":
    asyncio.run(probe())
