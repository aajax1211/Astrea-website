@echo off
setlocal enabledelayedexpansion
title Astrea eDiscovery — GitHub Deploy

echo.
echo ============================================
echo   ASTREA eDISCOVERY — GitHub Deploy Tool
echo ============================================
echo.

REM ── Check if Git is installed ───────────────
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed on this machine.
    echo.
    echo Please download and install Git from:
    echo https://git-scm.com/download/win
    echo.
    echo After installing, run this file again.
    pause
    exit /b 1
)

REM ── Get GitHub details ──────────────────────
echo We need a few details to set up your GitHub repo.
echo.

set /p GITHUB_USER=Enter your GitHub username: 
set /p GITHUB_REPO=Enter your repository name (e.g. astrea-website): 
set /p COMMIT_MSG=Enter a commit message (or press Enter for default): 

if "!COMMIT_MSG!"=="" set COMMIT_MSG=Update Astrea eDiscovery website

echo.
echo ============================================
echo  Summary
echo ============================================
echo  GitHub User : !GITHUB_USER!
echo  Repo Name   : !GITHUB_REPO!
echo  Commit Msg  : !COMMIT_MSG!
echo  Remote URL  : https://github.com/!GITHUB_USER!/!GITHUB_REPO!.git
echo ============================================
echo.

set /p CONFIRM=Does this look correct? (Y/N): 
if /i "!CONFIRM!" neq "Y" (
    echo Cancelled. Run the file again to retry.
    pause
    exit /b 0
)

echo.

REM ── Create .gitignore ───────────────────────
echo Creating .gitignore...
(
    echo # System files
    echo .DS_Store
    echo Thumbs.db
    echo desktop.ini
    echo.
    echo # Editor folders
    echo .vscode/
    echo .idea/
    echo.
    echo # Temp files
    echo *.log
    echo *.tmp
) > .gitignore
echo Done.

REM ── Init or reinit git ──────────────────────
if exist ".git" (
    echo Git already initialized — skipping init.
) else (
    echo Initializing Git repository...
    git init
    echo Done.
)

REM ── Stage all files ─────────────────────────
echo.
echo Staging all files...
git add .
echo Done.

REM ── Commit ──────────────────────────────────
echo.
echo Committing...
git commit -m "!COMMIT_MSG!"

REM ── Set branch to main ──────────────────────
echo.
echo Setting branch to main...
git branch -M main

REM ── Set remote ──────────────────────────────
echo.
echo Setting remote origin...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/!GITHUB_USER!/!GITHUB_REPO!.git

REM ── Push ────────────────────────────────────
echo.
echo Pushing to GitHub...
echo (A browser window or login prompt may appear — sign in with your GitHub account)
echo.
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Push failed. Common reasons:
    echo   1. The repository doesn't exist on GitHub yet.
    echo      Go to github.com and create a repo named: !GITHUB_REPO!
    echo      Then run this file again.
    echo.
    echo   2. Wrong username or repo name — run the file again.
    echo.
    echo   3. Not logged in — make sure Git credential manager is set up.
    pause
    exit /b 1
)

echo.
echo ============================================
echo  SUCCESS! Your site is on GitHub.
echo ============================================
echo.
echo  Next step — Enable GitHub Pages:
echo  1. Go to: https://github.com/!GITHUB_USER!/!GITHUB_REPO!/settings/pages
echo  2. Under Source: select "Deploy from a branch"
echo  3. Branch: main  /  Folder: / (root)
echo  4. Click Save
echo.
echo  Your site will be live in ~1 minute at:
echo  https://!GITHUB_USER!.github.io/!GITHUB_REPO!/
echo.

REM ── Open GitHub Pages settings automatically ─
set /p OPEN=Open GitHub Pages settings now in browser? (Y/N): 
if /i "!OPEN!"=="Y" (
    start "" "https://github.com/!GITHUB_USER!/!GITHUB_REPO!/settings/pages"
)

echo.
echo Done! Run this file anytime to push future updates.
pause
