#!/usr/bin/env bash

set -euo pipefail

mkdir -p build

if command -v xelatex >/dev/null 2>&1; then
  echo "Building main.tex..."
  xelatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
  xelatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
  find . -maxdepth 1 \( \
    -name '*.aux' -o \
    -name '*.log' -o \
    -name '*.toc' -o \
    -name '*.out' -o \
    -name '*.bcf' -o \
    -name '*.blg' -o \
    -name '*.run.xml' -o \
    -name '*.fdb_latexmk' -o \
    -name '*.fls' \
  \) -delete
  find build -maxdepth 1 \( \
    -name '*.aux' -o \
    -name '*.log' -o \
    -name '*.toc' -o \
    -name '*.out' -o \
    -name '*.bcf' -o \
    -name '*.blg' -o \
    -name '*.run.xml' -o \
    -name '*.fdb_latexmk' -o \
    -name '*.fls' \
  \) -delete
else
  echo "XeLaTeX is not available."
  exit 1
fi

echo "Done."
