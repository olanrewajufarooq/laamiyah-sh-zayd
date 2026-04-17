@echo off
setlocal

python "%~dp0generate_prelim_samples.py"
if errorlevel 1 exit /b 1

echo Prelim previews written to sample\prelim.
