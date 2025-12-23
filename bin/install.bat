@echo off
REM NVM for Windows Installation Script
REM This script installs nvm and sets up the required environment variables

setlocal enabledelayedexpansion

REM Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ERROR: This installer must be run as Administrator!
    echo Please right-click this file and select "Run as administrator"
    echo.
    pause
    exit /b 1
)

cls
echo.
echo ============================================
echo     NVM for Windows Installer v1.2.2
echo ============================================
echo.

REM Default install directory
set "INSTALL_DIR=%LOCALAPPDATA%\nvm"
set "SYMLINK_DIR=C:\nvm4w\nodejs"

REM Ask user for custom paths (optional)
echo.
echo Press ENTER to use default locations:
echo   Install: %INSTALL_DIR%
echo   Symlink: %SYMLINK_DIR%
echo.
echo Or enter custom paths:
set /p INSTALL_DIR="Enter installation directory (press ENTER for default): "
set /p SYMLINK_DIR="Enter symlink directory (press ENTER for default): "

echo.
echo Installing NVM to: %INSTALL_DIR%
echo Symlink location: %SYMLINK_DIR%
echo.

REM Run the installer
nvm-installer.exe "%INSTALL_DIR%" "%SYMLINK_DIR%"

if %errorLevel% equ 0 (
    echo.
    echo ============================================
    echo     Installation Complete!
    echo ============================================
    echo.
    echo Please close all open command prompts and PowerShell windows.
    echo Then open a new terminal and verify with: nvm --version
    echo.
) else (
    echo.
    echo ERROR: Installation failed!
    echo.
)

pause
