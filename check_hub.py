import httpx
import asyncio
import json

async def check_hub():
    url = "http://127.0.0.1:4400/emulators"
    print(f"🔍 Checking Emulator Hub at {url}...")
    
    async with httpx.AsyncClient() as client:
        try:
            resp = await client.get(url)
            print(f"Status: {resp.status_code}")
            if resp.status_code == 200:
                print("Emulator Hub Response:")
                print(json.dumps(resp.json(), indent=2))
            else:
                print(f"Error: {resp.text}")
        except Exception as e:
            print(f"Failed to connect to Hub: {e}")

if __name__ == "__main__":
    asyncio.run(check_hub())
