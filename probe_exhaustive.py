import httpx
import asyncio
import itertools

async def probe():
    base = "http://127.0.0.1:9399"
    
    versions = ["v1beta", "v1", "v1alpha"]
    projects = ["bizpharma-4e73a", "demo-bizpharma-4e73a"]
    locations = ["asia-south1", "us-central1"]
    services = ["bizpharma-service"]
    connectors = ["biz-pharma", "biz_pharma", "default"]
    
    print(f"🔍 Starting exhaustive probe of {base}...")
    
    async with httpx.AsyncClient() as client:
        # Generate all combinations
        for v, p, l, s, c in itertools.product(versions, projects, locations, services, connectors):
            path = f"/{v}/projects/{p}/locations/{l}/services/{s}/connectors/{c}:executeGraphql"
            url = f"{base}{path}"
            
            try:
                # We expect 404 if path is wrong.
                # If path is correct but method/body is wrong, we might get 400 or 405 or 200.
                # Just looking for NOT 404.
                resp = await client.post(url, json={"query": "{ __typename }", "operationName": "Probe"})
                
                if resp.status_code != 404:
                    print(f"✅ FOUND! Status {resp.status_code}")
                    print(f"   URL: {url}")
                    print(f"   Response: {resp.text[:200]}")
                    return # Stop on first hit
                    
            except Exception as e:
                pass
                
        print("❌ Exhaustive probe finished. No valid endpoint found.")

if __name__ == "__main__":
    asyncio.run(probe())
