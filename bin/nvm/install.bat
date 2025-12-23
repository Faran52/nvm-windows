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

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"

REM Default install directory
set "INSTALL_DIR=%LOCALAPPDATA%\nvm"
set "SYMLINK_DIR=C:\nvm4w\nodejs"

REM Ask user for custom paths
echo.
echo Current directory: %SCRIPT_DIR%
echo.
echo Default installation locations:
echo   Install: %INSTALL_DIR%
echo   Symlink: %SYMLINK_DIR%
echo.
set /p CUSTOM_INSTALL="Enter custom install directory (or press ENTER for default): "
if not "!CUSTOM_INSTALL!"=="" set "INSTALL_DIR=!CUSTOM_INSTALL!"

set /p CUSTOM_SYMLINK="Enter custom symlink directory (or press ENTER for default): "
if not "!CUSTOM_SYMLINK!"=="" set "SYMLINK_DIR=!CUSTOM_SYMLINK!"

echo.
echo Installing NVM to: %INSTALL_DIR%
echo Symlink location: %SYMLINK_DIR%
echo.

REM Create install directory
if not exist "%INSTALL_DIR%" (
    echo Creating directory: %INSTALL_DIR%
    mkdir "%INSTALL_DIR%"
    if errorlevel 1 (
        echo ERROR: Failed to create directory
        pause
        exit /b 1
    )
)

REM Copy nvm.exe to install directory
echo Copying nvm.exe to %INSTALL_DIR%...
copy /Y "%SCRIPT_DIR%nvm.exe" "%INSTALL_DIR%\nvm.exe"
if errorlevel 1 (
    echo ERROR: Failed to copy nvm.exe
    pause
    exit /b 1
)
echo Done!
echo.

REM Create settings.txt file
echo Creating settings.txt configuration file...
(
    echo root: %INSTALL_DIR%
    echo path: %SYMLINK_DIR%
    echo arch: 64
    echo proxy: none
) > "%INSTALL_DIR%\settings.txt"
if errorlevel 1 (
    echo WARNING: Failed to create settings.txt
) else (
    echo ✓ Created settings.txt
)
echo.

REM Set environment variables
echo Setting environment variables...

REM Set NVM_HOME
setx NVM_HOME "%INSTALL_DIR%"
if errorlevel 1 (
    echo WARNING: Failed to set NVM_HOME
) else (
    echo ✓ Set NVM_HOME = %INSTALL_DIR%
)

REM Set NVM_SYMLINK
setx NVM_SYMLINK "%SYMLINK_DIR%"
if errorlevel 1 (
    echo WARNING: Failed to set NVM_SYMLINK
) else (
    echo ✓ Set NVM_SYMLINK = %SYMLINK_DIR%
)

REM Update PATH using registry
echo.
echo Updating system PATH...

for /f "tokens=2*" %%A in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path ^| findstr /i path') do set "CURRENT_PATH=%%B"

REM Check if NVM_HOME is already in PATH
echo %CURRENT_PATH% | findstr /i "NVM_HOME" >nul
if errorlevel 1 (
    REM Add NVM_HOME to PATH
    setx /M PATH "%CURRENT_PATH%;%%NVM_HOME%%"
    echo ✓ Added %%NVM_HOME%% to PATH
) else (
    echo ✓ %%NVM_HOME%% already in PATH
)

REM Check if NVM_SYMLINK is already in PATH
echo %CURRENT_PATH% | findstr /i "NVM_SYMLINK" >nul
if errorlevel 1 (
    REM Add NVM_SYMLINK to PATH
    for /f "tokens=2*" %%A in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path ^| findstr /i path') do setx /M PATH "%%B;%%NVM_SYMLINK%%"
    echo ✓ Added %%NVM_SYMLINK%% to PATH
) else (
    echo ✓ %%NVM_SYMLINK%% already in PATH
)

echo.
echo ============================================
echo     Installation Complete!
echo ============================================
echo.
echo IMPORTANT: Close all open command prompts and PowerShell windows
echo Then open a NEW terminal and verify the installation:
echo.
echo   nvm --version
echo.
echo Next steps:
echo   1. Install Node.js: nvm install latest
echo   2. Use a version: nvm use latest
echo   3. Verify: node --version
echo.
echo For help: nvm --help
echo.

pause

