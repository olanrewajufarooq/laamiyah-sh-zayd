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

set "INPUTS="
for %%F in (src\*.md) do (
    set "INPUTS=!INPUTS! "%%F""
)

if not defined INPUTS (
    echo No Markdown files found in src\
    exit /b 1
)

echo Building HTML...
pandoc --defaults metadata/html.yaml %INPUTS%
if errorlevel 1 exit /b 1

set "PDF_READY=1"
%TYPST_CMD% --version >nul 2>nul
if errorlevel 1 set "PDF_READY=0"

if "%PDF_READY%"=="1" (
    echo Building PDF...
    pandoc --pdf-engine="%TYPST_CMD%" --defaults metadata/pdf.yaml %INPUTS%
    if errorlevel 1 exit /b 1
) else (
    echo Skipping PDF build because Typst is not runnable from cmd.exe.
    echo Set TYPST_EXE to the full path of typst.exe or reinstall Typst.
)

echo Done.
pause
