#!/usr/bin/env bash

set -euo pipefail

if command -v xelatex >/dev/null 2>&1; then
  echo "XeLaTeX is installed and runnable."
else
  echo "XeLaTeX is missing."
  echo "Install a TeX distribution that provides xelatex."
  exit 1
fi
