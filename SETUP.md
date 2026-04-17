# XeLaTeX Setup

This repository is built for XeLaTeX.

## Required Tool

You need `xelatex` available on your `PATH`.

Verify:

```powershell
xelatex --version
```

## Windows

Install a TeX distribution that includes XeLaTeX, for example:

- TeX Live
- MiKTeX

After installation, open a fresh terminal and run:

```powershell
xelatex --version
where.exe xelatex
```

## macOS

Install MacTeX or TeX Live, then verify:

```bash
xelatex --version
```

## Linux

Install XeLaTeX and common LaTeX extras from your distribution.

Example for Ubuntu / Debian:

```bash
sudo apt-get update
sudo apt-get install -y texlive-xetex texlive-latex-extra texlive-fonts-recommended
```

Then verify:

```bash
xelatex --version
```

## Build

### Windows

```powershell
build.bat
```

### macOS / Linux

```bash
./build.sh
```

The output PDF is:

```text
build/main.pdf
```

