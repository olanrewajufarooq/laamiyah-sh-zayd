#!/usr/bin/env bash

set -euo pipefail

if command -v python3 >/dev/null 2>&1; then
  python3 "$(dirname "$0")/generate_prelim_samples.py"
else
  python "$(dirname "$0")/generate_prelim_samples.py"
fi

echo "Prelim previews written to sample/prelim."
