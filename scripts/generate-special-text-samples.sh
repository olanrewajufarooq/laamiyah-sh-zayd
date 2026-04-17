#!/usr/bin/env sh
set -eu

python "$(dirname "$0")/generate_special_text_samples.py"
echo "Special text previews written to sample/special-text."
