# Local Installation Guide

Use this guide to set up everything needed to build this project locally with **Pandoc + Typst**.

## Quick Start

1. Check whether `pandoc` and `typst` are already installed.
2. Install any missing tools for your operating system.
3. Verify the installation.
4. Build the project.

## 0. Check What Is Already Installed

Run:

```bash
pandoc --version
typst --version
```

If both commands work, you can skip to [4. Build the Project](#4-build-the-project).

## 1. Install Pandoc

### macOS

```bash
brew install pandoc
```

### Ubuntu / Debian

```bash
sudo apt-get update
sudo apt-get install pandoc
```

### Windows

Choose one option:

Option A: Official installer

Download and install Pandoc from:
https://pandoc.org/installing.html

Option B: `winget`

```powershell
winget install --source winget --exact --id JohnMacFarlane.Pandoc
```

Option C: Chocolatey

```powershell
choco install pandoc
```

## 2. Install Typst

### macOS

```bash
brew install typst
```

### Linux

Install the `typst` package from your distribution if it is available.

If your distribution does not provide it, download the compiler from:
https://typst.app/open-source/

### Windows

Strongly recommended: use the direct ZIP download.

Option A: Direct download

Download the Windows ZIP from:
https://typst.app/open-source/

Then:

1. Unzip the archive.
2. Move `typst.exe` to a permanent folder.
3. Add that folder to your `PATH`.
4. Open a fresh terminal before testing it.

Option B: `winget`

```powershell
winget install typst
```

`winget` can break at times on Windows by leaving behind a bad `typst.exe` shim in the WinGet links directory. If `typst --version` fails, or if `where.exe typst` points to `C:\Users\olanr\AppData\Local\Microsoft\WinGet\Links\typst.exe`, remove that broken install and use the direct ZIP instead.

## 3. Post-Install Verification

Run:

```bash
pandoc --version
typst --version
```

Both commands should complete successfully.

On Windows, also run:

```powershell
where.exe typst
```

It should point to your real Typst install location, for example:

```text
C:\Program Files\typst\typst.exe
```

## 4. Build the Project

The required fonts are bundled with this repository in `assets/fonts`, so you do not need to install them separately for local builds.

### macOS / Linux

```bash
./build.sh
```

### Windows

Run:

```powershell
build.bat
```
