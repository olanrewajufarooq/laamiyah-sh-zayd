# XeLaTeX Setup

This repository is built for XeLaTeX and local font loading through `fontspec`.

## Required Tool

You need `xelatex` available either on your `PATH` or through the Windows override used by the build script.

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

If `xelatex` works in PowerShell but not from `cmd.exe`, `build.bat` supports an override:

```powershell
$env:XELATEX_EXE = 'C:\full\path\to\xelatex.exe'
build.bat
```

## macOS

Install MacTeX or TeX Live, then verify:

```bash
xelatex --version
```

## Linux

Install XeLaTeX plus the LaTeX extras used by this package.

Example for Ubuntu / Debian:

```bash
sudo apt-get update
sudo apt-get install -y \
  texlive-xetex \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-pictures \
  texlive-plain-generic
```

Then verify:

```bash
xelatex --version
```

## Bundled Fonts

The template loads fonts from [assets/fonts](./assets/fonts), so you do not need those families installed system-wide. The currently bundled families are:

- `NotoSerif`
- `NeueHaasText`
- `Amiri`

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

The build scripts also:

- clean common `.aux` / `.log` / `.toc` style byproducts
- set `TEXINPUTS` so TeX files in subdirectories can still resolve the repo-root style files

## Husky Hooks

This repo can use Husky to keep generated preview samples in sync during commits.

Install it once after cloning:

```bash
npm install
```

The pre-commit hook behaves like this:

- if `bookish-frontpage.sty` is staged, it runs `scripts/generate-frontpage-samples.*`
  for the current OS and stages `sample/frontpage/`
- if `bookish-prelim.sty` is staged, it runs `scripts/generate-prelim-samples.*`
  for the current OS and stages `sample/prelim/`

The sample generators compile each preview twice with XeLaTeX before converting
it to PNG, matching the normal build flow.
