@echo off
setlocal enabledelayedexpansion
title Astrea eDiscovery — GitHub Deploy

echo.
echo ============================================
echo   ASTREA eDISCOVERY — GitHub Deploy Tool
echo ============================================
echo.

REM ── Check Git installed ─────────────────────
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed.
    echo Download from: https://git-scm.com/download/win
    pause & exit /b 1
)

REM ── Get GitHub details ──────────────────────
echo Please answer the questions below.
echo.
set /p GITHUB_USER=GitHub username: 
set /p GITHUB_REPO=Repository name (e.g. astrea-website): 
set /p GIT_NAME=Your full name (for Git commits): 
set /p GIT_EMAIL=Your email (used for Git commits): 
set /p COMMIT_MSG=Commit message (or press Enter for default): 

if "!COMMIT_MSG!"=="" set COMMIT_MSG=Initial commit - Astrea eDiscovery website

echo.
echo ============================================
echo  Summary
echo ============================================
echo  GitHub User : !GITHUB_USER!
echo  Repo Name   : !GITHUB_REPO!
echo  Your Name   : !GIT_NAME!
echo  Your Email  : !GIT_EMAIL!
echo  Commit Msg  : !COMMIT_MSG!
echo  Remote URL  : https://github.com/!GITHUB_USER!/!GITHUB_REPO!.git
echo ============================================
echo.
set /p CONFIRM=Does this look correct? (Y/N): 
if /i "!CONFIRM!" neq "Y" (
    echo Cancelled. Run the file again.
    pause & exit /b 0
)

echo.

REM ── Configure Git identity ──────────────────
echo Configuring Git identity...
git config --global user.name "!GIT_NAME!"
git config --global user.email "!GIT_EMAIL!"
echo Done.

REM ── Create .gitignore ───────────────────────
echo Creating .gitignore...
(
    echo .DS_Store
    echo Thumbs.db
    echo desktop.ini
    echo .vscode/
    echo .idea/
    echo *.log
    echo *.tmp
) > .gitignore

REM ── Init git ────────────────────────────────
if exist ".git" (
    echo Git already initialized - skipping.
) else (
    echo Initializing Git...
    git init
)

REM ── Set branch to main BEFORE committing ────
echo Setting branch to main...
git checkout -b main >nul 2>&1
if %errorlevel% neq 0 (
    git checkout main >nul 2>&1
)

REM ── Stage all files ─────────────────────────
echo Staging all files...
git add -A

REM ── Check if anything staged ────────────────
git diff --cached --quiet
if %errorlevel% equ 0 (
    echo Nothing new to commit - going straight to push...
    goto :push
)

REM ── Commit ──────────────────────────────────
echo Committing...
git commit -m "!COMMIT_MSG!"
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Commit failed. See messages above.
    pause & exit /b 1
)

:push
REM ── Set remote ──────────────────────────────
echo Setting remote...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/!GITHUB_USER!/!GITHUB_REPO!.git

REM ── Push ────────────────────────────────────
echo.
echo Pushing to GitHub...
echo (A login prompt may appear - sign in with your GitHub account)
echo.
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Push failed. Most likely fix:
    echo  1. Go to https://github.com/new
    echo  2. Create repo named exactly: !GITHUB_REPO!
    echo  3. Leave it EMPTY - no README, no .gitignore
    echo  4. Run this file again
    echo.
    pause & exit /b 1
)

echo.
echo ============================================
echo  SUCCESS! Code is on GitHub.
echo ============================================
echo.
echo  Now enable GitHub Pages:
echo  1. Source: Deploy from a branch
echo  2. Branch: main  Folder: / (root)
echo  3. Click Save - live in ~1 min at:
echo     https://!GITHUB_USER!.github.io/!GITHUB_REPO!/
echo.

set /p OPEN=Open GitHub Pages settings now? (Y/N): 
if /i "!OPEN!"=="Y" (
    start "" "https://github.com/!GITHUB_USER!/!GITHUB_REPO!/settings/pages"
)

echo.
echo Use update.bat for all future changes.
pause
