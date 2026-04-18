@echo off
setlocal

python "%~dp0generate_chapter_samples.py"
if errorlevel 1 exit /b 1

echo Chapter previews written to sample\chapters.
