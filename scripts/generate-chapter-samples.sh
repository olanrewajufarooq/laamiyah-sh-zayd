#!/usr/bin/env sh
set -eu

python "$(dirname "$0")/generate_chapter_samples.py"
echo "Chapter previews written to sample/chapters."
