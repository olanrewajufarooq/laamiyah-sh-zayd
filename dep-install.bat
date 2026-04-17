@echo off
setlocal

set "LATEX_CMD=xelatex"
if defined XELATEX_EXE set "LATEX_CMD=%XELATEX_EXE%"

"%LATEX_CMD%" --version >nul 2>nul
if errorlevel 1 (
    echo XeLaTeX is not runnable.
    echo Install a TeX distribution that includes xelatex.
    exit /b 1
)

echo XeLaTeX is installed and runnable.
