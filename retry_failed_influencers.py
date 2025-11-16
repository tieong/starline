#!/usr/bin/env python3
"""Script to retry failed French influencers with host networking."""

import requests
import json
import time

# API Configuration
API_BASE_URL = "http://localhost:8000"
ANALYZE_ENDPOINT = f"{API_BASE_URL}/api/influencers/analyze"

# Failed influencers to retry
FAILED_INFLUENCERS = [
    "Angele VL",  # Try with her stage name variation
    "Giuseppa",
    "Lea Elui Ginet",  # Full name
    "Pitch Addict",
    "YASS",  # Shorter variation
]

def analyze_influencer(name: str) -> dict:
    """Analyze a single influencer."""
    print(f"\n{'='*80}")
    print(f"Analyzing: {name}")
    print(f"{'='*80}")

    try:
        response = requests.post(
            ANALYZE_ENDPOINT,
            json={"name": name},
            timeout=300
        )

        if response.status_code == 200:
            data = response.json()
            print(f"✓ Successfully analyzed {name}")
            print(f"  - ID: {data.get('id')}")
            print(f"  - Platforms: {len(data.get('platforms', []))}")
            print(f"  - Products: {len(data.get('products', []))}")
            print(f"  - Connections: {len(data.get('connections', []))}")
            return {"success": True, "name": name, "data": data}
        else:
            print(f"✗ Failed: {response.status_code}")
            print(f"  Response: {response.text[:200]}")
            return {"success": False, "name": name, "error": response.text}

    except Exception as e:
        print(f"✗ Error: {str(e)}")
        return {"success": False, "name": name, "error": str(e)}

def main():
    """Main function."""
    print("="*80)
    print("Retrying Failed French Influencers")
    print("="*80)
    print(f"\nRetrying {len(FAILED_INFLUENCERS)} influencers...")

    results = []
    successful = 0
    failed = 0

    for i, influencer in enumerate(FAILED_INFLUENCERS, 1):
        print(f"\n[{i}/{len(FAILED_INFLUENCERS)}] Processing: {influencer}")

        result = analyze_influencer(influencer)
        results.append(result)

        if result["success"]:
            successful += 1
        else:
            failed += 1

        if i < len(FAILED_INFLUENCERS):
            print("Waiting 2 seconds...")
            time.sleep(2)

    # Summary
    print("\n" + "="*80)
    print("RETRY SUMMARY")
    print("="*80)
    print(f"Total: {len(FAILED_INFLUENCERS)}")
    print(f"Successful: {successful}")
    print(f"Failed: {failed}")

    if successful > 0:
        print("\nSuccessful:")
        for r in results:
            if r["success"]:
                print(f"  ✓ {r['name']}")

    if failed > 0:
        print("\nFailed:")
        for r in results:
            if not r["success"]:
                print(f"  ✗ {r['name']}: {r['error'][:100]}")

    # Save results
    with open("retry_results.json", "w") as f:
        json.dump(results, f, indent=2)
    print(f"\n📁 Results saved to: retry_results.json")

if __name__ == "__main__":
    main()
