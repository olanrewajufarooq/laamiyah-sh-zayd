#!/usr/bin/env bash

set -euo pipefail

mkdir -p build

pdf_inputs=(src/chapters/*.md)

if [[ ${#pdf_inputs[@]} -eq 0 ]]; then
  echo "No PDF content files found in src/"
  exit 1
fi

if command -v typst >/dev/null 2>&1; then
  echo "Preparing PDF front matter..."
  grep -v '^:::' src/prelims/01-translators-introduction.md > build/translator-introduction.md

  echo "Rendering Typst source..."
  pandoc --defaults metadata/pdf.yaml "${pdf_inputs[@]}"

  echo "Rendering Translator's Introduction..."
  pandoc build/translator-introduction.md -t typst --output build/translator-introduction.typ

  echo "Building PDF..."
  typst compile --root . --font-path assets/fonts build/book.typ build/book.pdf
else
  echo "Skipping PDF build because typst is not available."
fi

echo "Done."
