#!/usr/bin/env bash

set -euo pipefail

if command -v python3 >/dev/null 2>&1; then
  python3 "$(dirname "$0")/generate_frontpage_samples.py"
else
  python "$(dirname "$0")/generate_frontpage_samples.py"
fi

echo "Frontpage previews written to sample/frontpage."
