#!/usr/bin/env python3
"""Generate a PNG with the OpenAI Images API and save it to a local file."""

import argparse
import base64
import json
import os
import sys
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--prompt", required=True, help="Description of the image to generate")
    parser.add_argument("--output", required=True, type=Path, help="Destination PNG file")
    parser.add_argument("--model", default="gpt-image-2.5-sunburst", help="OpenAI image model")
    parser.add_argument(
        "--size",
        choices=("1024x1024", "1536x1024", "1024x1536"),
        default="1024x1024",
    )
    parser.add_argument("--quality", choices=("low", "medium"), default="medium")
    args = parser.parse_args()

    key = os.environ.get("OPENAI_API_KEY")
    if not key:
        parser.error("OPENAI_API_KEY is not set in the OpenCode service environment")
    if args.output.suffix.lower() != ".png":
        parser.error("--output must end in .png")
    output = args.output.expanduser().resolve()
    if output.exists():
        parser.error(f"refusing to overwrite an existing file: {output}")

    request = Request(
        "https://api.openai.com/v1/images/generations",
        data=json.dumps(
            {
                "model": args.model,
                "prompt": args.prompt,
                "size": args.size,
                "quality": args.quality,
                "n": 1,
                "output_format": "png",
            }
        ).encode(),
        headers={"Authorization": f"Bearer {key}", "Content-Type": "application/json"},
        method="POST",
    )
    try:
        with urlopen(request, timeout=240) as response:
            result = json.load(response)
    except HTTPError as exc:
        try:
            detail = json.load(exc).get("error", {}).get("message", exc.reason)
        except (ValueError, AttributeError):
            detail = exc.reason
        print(f"OpenAI image generation failed ({exc.code}): {detail}", file=sys.stderr)
        return 1
    except (URLError, TimeoutError) as exc:
        print(f"OpenAI image generation failed: {exc}", file=sys.stderr)
        return 1

    try:
        image = base64.b64decode(result["data"][0]["b64_json"], validate=True)
    except (KeyError, IndexError, ValueError) as exc:
        print(f"OpenAI returned no PNG image: {exc}", file=sys.stderr)
        return 1
    output.parent.mkdir(parents=True, exist_ok=True)
    # Exclusive creation also protects against another process creating it during generation.
    with output.open("xb") as file:
        file.write(image)
    print(output)
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except OSError as exc:
        print(f"Could not save image: {exc}", file=sys.stderr)
        sys.exit(1)
