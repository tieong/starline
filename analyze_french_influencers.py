#!/usr/bin/env python3
"""Script to analyze top 10 French influencers using the Starline API."""

import requests
import json
import time
from typing import List, Dict

# API Configuration
API_BASE_URL = "http://localhost:8000"
ANALYZE_ENDPOINT = f"{API_BASE_URL}/api/influencers/analyze"

# Top 10 French Influencers
FRENCH_INFLUENCERS = [
    "Nabilla Vergara",
    "Angèle",
    "Lena Mahfouf",
    "Marie Lopez",
    "Hugo Hilaire",
    "Giuseppa",
    "Cédric Grolet",
    "Léa Elui",
    "Pitch Addict",
    "YASS OOTD",
]


def analyze_influencer(name: str) -> Dict:
    """Analyze a single influencer using the API.

    Args:
        name: The influencer's name

    Returns:
        Dict with analysis results or error information
    """
    print(f"\n{'='*80}")
    print(f"Analyzing: {name}")
    print(f"{'='*80}")

    try:
        response = requests.post(
            ANALYZE_ENDPOINT,
            json={"name": name},
            timeout=300  # 5 minute timeout for analysis
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
            print(f"✗ Failed to analyze {name}: {response.status_code}")
            print(f"  Response: {response.text[:200]}")
            return {"success": False, "name": name, "error": response.text}

    except requests.exceptions.Timeout:
        print(f"✗ Timeout analyzing {name}")
        return {"success": False, "name": name, "error": "Timeout"}
    except Exception as e:
        print(f"✗ Error analyzing {name}: {str(e)}")
        return {"success": False, "name": name, "error": str(e)}


def main():
    """Main function to analyze all French influencers."""
    print("="*80)
    print("French Influencers Analysis")
    print("="*80)
    print(f"\nAnalyzing {len(FRENCH_INFLUENCERS)} influencers...")

    results = []
    successful = 0
    failed = 0

    for i, influencer in enumerate(FRENCH_INFLUENCERS, 1):
        print(f"\n[{i}/{len(FRENCH_INFLUENCERS)}] Processing: {influencer}")

        result = analyze_influencer(influencer)
        results.append(result)

        if result["success"]:
            successful += 1
        else:
            failed += 1

        # Small delay between requests to avoid overwhelming the API
        if i < len(FRENCH_INFLUENCERS):
            print("Waiting 2 seconds before next analysis...")
            time.sleep(2)

    # Print summary
    print("\n" + "="*80)
    print("ANALYSIS SUMMARY")
    print("="*80)
    print(f"Total: {len(FRENCH_INFLUENCERS)}")
    print(f"Successful: {successful}")
    print(f"Failed: {failed}")
    print("\nSuccessful analyses:")
    for result in results:
        if result["success"]:
            print(f"  ✓ {result['name']}")

    if failed > 0:
        print("\nFailed analyses:")
        for result in results:
            if not result["success"]:
                print(f"  ✗ {result['name']}: {result['error'][:100]}")

    # Save results to file
    output_file = "french_influencers_analysis.json"
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    print(f"\n📁 Full results saved to: {output_file}")


if __name__ == "__main__":
    main()
