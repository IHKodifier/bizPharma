import httpx
import asyncio

async def probe_headers():
    url = "http://127.0.0.1:9399/graphql"
    
    headers_list = [
        {},
        {"X-Firebase-Project": "bizpharma-4e73a"},
        {"X-Goog-User-Project": "bizpharma-4e73a"},
        {"Authorization": "Bearer owner"}
    ]
    
    print(f"🔍 Probing {url} with headers...")
    
    async with httpx.AsyncClient() as client:
        for h in headers_list:
            try:
                # Try POST with minimal query
                resp = await client.post(url, json={"query": "{ __typename }"}, headers=h)
                print(f"Headers {h} -> {resp.status_code}")
                if resp.status_code != 404:
                    print(f"   Response: {resp.text[:200]}")
            except Exception as e:
                print(e)
                
    # Also try the full path with headers?
    # Maybe the "404" is actually "Method Not Allowed" presented as 404?
    # No, status code is 404.

if __name__ == "__main__":
    asyncio.run(probe_headers())
