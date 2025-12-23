# NVM for Windows v1.2.2 - Installation Guide

## Package Contents

- **nvm.exe** - The main NVM executable (Node Version Manager)
- **nvm-installer.exe** - The installer/setup utility for Windows
- **install.bat** - Easy installation batch script

## Quick Start

### Option 1: Automatic Installation (Easiest)
1. Right-click **install.bat** and select "Run as Administrator"
2. Follow the prompts
3. Restart your terminal/PowerShell
4. Verify: `nvm --version`

### Option 2: Manual Installation
1. Right-click **nvm-installer.exe** and select "Run as Administrator"
2. Follow the prompts
3. Restart your terminal/PowerShell

## What Gets Installed

The installer will:
- ✅ Create NVM installation directory (default: `%LOCALAPPDATA%\nvm`)
- ✅ Set `NVM_HOME` environment variable
- ✅ Set `NVM_SYMLINK` environment variable
- ✅ Create symlink directory (default: `C:\nvm4w\nodejs`)
- ✅ Update system PATH

## Requirements

- **OS:** Windows 10 or later
- **Admin Rights:** Required for environment variable setup
- **7-Zip:** Install from https://7-zip.org/ (needed for extracting Node.js)
  - Or: `choco install 7zip` (if using Chocolatey)

## Features

✨ **Version Management**
- Download and install multiple Node.js versions
- Switch between versions instantly
- Automatic version detection

🔧 **NPM Management**
- Built-in NPM support
- Automatic NPM version management

🚀 **System Integration**
- Command-line access: `nvm install latest`
- Works with PowerShell and CMD
- Global Node.js availability

## After Installation

```powershell
# Install the latest Node.js version
nvm install latest

# Or install a specific version
nvm install 18.12.0

# Switch to a version
nvm use 18.12.0

# Verify installation
node --version
npm --version
```

## Troubleshooting

**Issue:** `nvm` command not found
- **Solution:** Restart PowerShell/CMD to reload environment variables

**Issue:** "Permission denied" when installing Node.js
- **Solution:** Run PowerShell as Administrator

**Issue:** 7-Zip not found
- **Solution:** Install 7-Zip from https://7-zip.org/

## Uninstallation

1. Run `nvm unsubscribe` in PowerShell
2. Delete the NVM installation folder (default: `%LOCALAPPDATA%\nvm`)
3. Remove `%NVM_HOME%` and `%NVM_SYMLINK%` from environment variables manually

## More Information

- **GitHub:** https://github.com/coreybutler/nvm-windows
- **Node.js:** https://nodejs.org/

---

**Version:** 1.2.2  
**Author:** Faran.ali  
**Features:** 7z extraction support, improved Windows 10 compatibility
