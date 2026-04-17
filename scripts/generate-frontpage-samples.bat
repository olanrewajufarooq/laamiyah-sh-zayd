@echo off
setlocal

python "%~dp0generate_frontpage_samples.py"
if errorlevel 1 exit /b 1

echo Frontpage previews written to sample\frontpage.
