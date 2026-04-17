#!/usr/bin/env bash

set -euo pipefail

mkdir -p build

inputs=(src/*.md)

if [[ ! -e "${inputs[0]}" ]]; then
  echo "No Markdown files found in src/"
  exit 1
fi

echo "Building PDF..."
pandoc --defaults metadata/pdf.yaml "${inputs[@]}"

echo "Building HTML..."
pandoc --defaults metadata/html.yaml "${inputs[@]}"

echo "Done."
