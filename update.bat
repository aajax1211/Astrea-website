@echo off
setlocal enabledelayedexpansion
title Astrea eDiscovery — Push Update

echo.
echo ============================================
echo   ASTREA eDISCOVERY — Push Update
echo ============================================
echo.

git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git not found. Run deploy.bat first.
    pause & exit /b 1
)

if not exist ".git" (
    echo [ERROR] Git not initialized here.
    echo Please run deploy.bat first.
    pause & exit /b 1
)

set /p COMMIT_MSG=What did you change? (commit message): 
if "!COMMIT_MSG!"=="" set COMMIT_MSG=Update website content

echo.
echo Staging changes...
git add .

echo Committing: !COMMIT_MSG!
git commit -m "!COMMIT_MSG!"

echo Pushing to GitHub...
git push

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Push failed. Check your internet connection
    echo or run deploy.bat again if the remote changed.
    pause & exit /b 1
)

echo.
echo ============================================
echo  Done! Changes are live in ~1 minute.
echo ============================================
echo.
pause
