@echo off
setlocal

python "%~dp0generate_special_text_samples.py"
if errorlevel 1 exit /b 1

echo Special text previews written to sample\special-text.
