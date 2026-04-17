@echo off
setlocal EnableDelayedExpansion

if not exist build mkdir build

pandoc --version >nul 2>nul
if errorlevel 1 (
    echo Pandoc is not runnable. Install Pandoc first.
    exit /b 1
)

set "TYPST_CMD=typst"
if defined TYPST_EXE set "TYPST_CMD=%TYPST_EXE%"

set "PDF_INPUTS="
for %%F in (src\chapters\*.md) do (
    set "PDF_INPUTS=!PDF_INPUTS! "%%F""
)

if not defined PDF_INPUTS (
    echo No PDF content files found in src\
    exit /b 1
)

set "PDF_READY=1"
%TYPST_CMD% --version >nul 2>nul
if errorlevel 1 set "PDF_READY=0"

if "%PDF_READY%"=="1" (
    echo Preparing PDF front matter...
    powershell -NoProfile -Command "Get-Content 'src\\prelims\\01-translators-introduction.md' | Where-Object { $_ -notmatch '^:::' } | Set-Content 'build\\translator-introduction.md'"
    if errorlevel 1 exit /b 1

    echo Rendering Typst source...
    pandoc --defaults metadata/pdf.yaml %PDF_INPUTS%
    if errorlevel 1 exit /b 1

    echo Rendering Translator's Introduction...
    pandoc build\translator-introduction.md -t typst --output build\translator-introduction.typ
    if errorlevel 1 exit /b 1

    echo Building PDF...
    "%TYPST_CMD%" compile --root . --font-path assets\fonts build\book.typ build\book.pdf
    if errorlevel 1 exit /b 1
) else (
    echo Skipping PDF build because Typst is not runnable from cmd.exe.
    echo Set TYPST_EXE to the full path of typst.exe or reinstall Typst.
)

echo Done.
pause
