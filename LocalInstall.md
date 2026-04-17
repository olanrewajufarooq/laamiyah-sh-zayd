# Local Installation Guide

This guide helps you set up everything needed to build PDF and HTML locally.

---

## 1. Install Pandoc

### Install Pandoc for macOS

```bash
brew install pandoc
```

### Install Pandoc for Ubuntu / Debian

```bash
sudo apt-get update
sudo apt-get install pandoc
```

## 2. Install LaTeX (XeLaTeX required)

### Install LaTeX for Ubuntu / Debian 

```bash
sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-latex-extra
```

### Install LaTeX for macOS

Install MacTeX:
https://www.tug.org/mactex/

## 3. Install Fonts (Arabic + English)

Recommended fonts:

Amiri (Arabic)
Noto Serif / Noto Sans (English)

### Install Fonts for Ubuntu / Debian

```bash
sudo apt-get install fonts-amiri fonts-noto
```

### Install Fonts for macOS

Install fonts via Font Book or download from the respective websites.

## 4. Verify Installation

```bash
pandoc --version
xelatex --version
```

## 5. Build the Project

```bash
make pdf
make html
```

Outputs will appear in the build/ directory.

## 6. Notes

XeLaTeX is required for proper Arabic rendering.
If fonts fail to load, ensure they are installed system-wide.