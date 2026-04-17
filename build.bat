@echo off
setlocal EnableDelayedExpansion

if not exist build mkdir build

set "LATEX_CMD=xelatex"
if defined XELATEX_EXE set "LATEX_CMD=%XELATEX_EXE%"

"%LATEX_CMD%" --version >nul 2>nul
if errorlevel 1 (
    echo XeLaTeX is not runnable from cmd.exe.
    echo Set XELATEX_EXE to the full path of xelatex.exe or reinstall your TeX distribution.
    exit /b 1
)

echo Building main.tex...
"%LATEX_CMD%" -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
if errorlevel 1 exit /b 1
"%LATEX_CMD%" -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
if errorlevel 1 exit /b 1

for %%F in (
    *.aux
    *.log
    *.toc
    *.out
    *.bcf
    *.blg
    *.run.xml
    *.fdb_latexmk
    *.fls
    build\*.aux
    build\*.log
    build\*.toc
    build\*.out
    build\*.bcf
    build\*.blg
    build\*.run.xml
    build\*.fdb_latexmk
    build\*.fls
) do (
    if exist "%%~F" del /q "%%~F"
)

echo Done.
