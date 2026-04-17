#!/usr/bin/env bash

set -e

echo "Checking and installing dependencies..."

# ----------------------------
# Helper: check command exists
# ----------------------------
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

OS="$(uname -s)"

# ----------------------------
# macOS
# ----------------------------
if [[ "$OS" == "Darwin" ]]; then
  echo "Detected macOS"

  if ! command_exists brew; then
    echo "Homebrew not found. Install it first:"
    echo "https://brew.sh/"
    exit 1
  fi

  if command_exists pandoc; then
    echo "Pandoc already installed."
  else
    echo "Installing Pandoc..."
    brew install pandoc
  fi

  if command_exists typst; then
    echo "Typst already installed."
  else
    echo "Installing Typst..."
    brew install typst
  fi

# ----------------------------
# Linux
# ----------------------------
elif [[ "$OS" == "Linux" ]]; then
  echo "Detected Linux"

  if command -v apt-get >/dev/null 2>&1; then

    if command_exists pandoc; then
      echo "Pandoc already installed."
    else
      echo "Installing Pandoc..."
      sudo apt-get update
      sudo apt-get install -y pandoc
    fi

    if command_exists typst; then
      echo "Typst already installed."
    else
      echo "Installing Typst..."
      TMP_DIR=$(mktemp -d)
      cd "$TMP_DIR"

      curl -LO https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz
      tar -xf typst-x86_64-unknown-linux-musl.tar.xz

      sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/

      cd - >/dev/null
      rm -rf "$TMP_DIR"
    fi

  else
    echo "Unsupported Linux distribution."
    echo "Please install pandoc and typst manually."
    exit 1
  fi

else
  echo "Unsupported OS: $OS"
  exit 1
fi

echo
echo "====================================="
echo "Dependency check complete."
echo "====================================="
echo
