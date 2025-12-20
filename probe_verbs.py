import httpx
import asyncio

async def probe_verbs():
    base = "http://127.0.0.1:9399/v1beta/projects/bizpharma-4e73a/locations/asia-south1/services/bizpharma-service/connectors/biz-pharma"
    
    suffixes = [
        ":executeGraphql",
        ":execute",
        ":executeQuery",
        ":executeMutation",
        "/execute",
        "/graphql"
    ]
    
    print(f"🔍 Probing suffixes at {base}...")
    
    async with httpx.AsyncClient() as client:
        for s in suffixes:
            url = f"{base}{s}"
            try:
                resp = await client.post(url, json={"query": "{ __typename }"})
                print(f"POST {s} -> {resp.status_code}")
                if resp.status_code != 404:
                    print(f"   Response: {resp.text[:200]}")
            except Exception as e:
                print(e)
        
        # Also try without connector?
        url2 = "http://127.0.0.1:9399/v1beta/projects/bizpharma-4e73a/locations/asia-south1/services/bizpharma-service:executeGraphql"
        try:
             resp = await client.post(url2, json={"query": "{ __typename }"})
             print(f"POST Service-Level -> {resp.status_code}")
        except: pass

if __name__ == "__main__":
    asyncio.run(probe_verbs())
