@echo off

echo Checking and installing dependencies...

:: ----------------------------
:: Check Pandoc
:: ----------------------------
pandoc --version >nul 2>nul
if %errorlevel% neq 0 (
    echo Pandoc not found. Installing...
    winget install --id JohnMacFarlane.Pandoc -e --source winget
) else (
    echo Pandoc already installed.
)

:: ----------------------------
:: Check Typst
:: ----------------------------
typst --version >nul 2>nul
if %errorlevel% neq 0 (
    echo Typst not found or not runnable. Installing...
    winget install typst
) else (
    echo Typst already installed.
)

echo.
echo =====================================
echo Dependency check complete.
echo =====================================


pause
