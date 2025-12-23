# NVM for Windows v1.2.2 - Installation Guide

## Package Contents

- **nvm.exe** - The main NVM executable (Node Version Manager)
- **install.bat** - Installation script (handles everything automatically)
- **README.md** - This file

## Quick Start

### Automatic Installation (Easiest)

1. **Right-click `install.bat`** and select **"Run as Administrator"**
2. Follow the on-screen prompts (or press ENTER for defaults)
3. **Close all open terminals/PowerShell windows**
4. **Open a new PowerShell/CMD window**
5. Verify installation: `nvm --version`

That's it! The script will:
- ✅ Copy nvm.exe to your NVM directory
- ✅ Set `NVM_HOME` environment variable
- ✅ Set `NVM_SYMLINK` environment variable  
- ✅ Update system PATH automatically
- ✅ Configure everything for Node.js version management

## System Requirements

- **OS:** Windows 10 or later
- **Admin Rights:** Required to run the installation script
- **7-Zip:** Required for extracting Node.js packages
  - Download from: https://7-zip.org/
  - Or install via Chocolatey: `choco install 7zip`

## Default Installation Paths

If you don't specify custom paths, the installer uses:
- **Install Directory:** `%LOCALAPPDATA%\nvm` (usually `C:\Users\YourUsername\AppData\Local\nvm`)
- **Symlink Directory:** `C:\nvm4w\nodejs` (for active Node.js version)

## After Installation

Once installed and you've reopened your terminal:

```powershell
# Install the latest Node.js
nvm install latest

# Or install a specific version
nvm install 18.12.0

# List installed versions
nvm list

# Switch to a version
nvm use 18.12.0

# Verify Node.js
node --version
npm --version
```

## Common Commands

```powershell
# Show help
nvm --help

# List all available Node.js versions
nvm list available

# Install LTS version
nvm install lts

# Uninstall a version
nvm uninstall 16.13.0

# Show current version
nvm current
```

## Troubleshooting

**Issue:** `nvm` command not found
- **Solution:** Restart PowerShell/CMD completely (close and reopen window)

**Issue:** Permission denied when installing Node.js
- **Solution:** Run PowerShell as Administrator

**Issue:** Cannot extract Node.js files
- **Solution:** Install 7-Zip from https://7-zip.org/

**Issue:** Install script fails
- **Solution:** 
  1. Make sure you're running as Administrator
  2. Check that you have write permissions to the destination folder
  3. Disable antivirus temporarily if it's blocking file operations

## Uninstallation

To completely remove NVM:

1. Run in PowerShell:
   ```powershell
   nvm unsubscribe
   ```

2. Delete the NVM installation folder (default: `%LOCALAPPDATA%\nvm`)

3. Manually remove environment variables from System Properties:
   - Open "Edit environment variables for your account"
   - Remove `NVM_HOME` and `NVM_SYMLINK` variables
   - Remove `%NVM_HOME%` and `%NVM_SYMLINK%` from PATH

## Features

🚀 **Version Management**
- Download and install multiple Node.js versions
- Switch between versions instantly
- Automatic version detection

📦 **NPM Integration**
- Built-in NPM support
- Automatic NPM version management
- Global package management

🔧 **System Integration**
- Works with PowerShell, CMD, and Git Bash
- Environment variable management
- Automatic PATH configuration

## More Information

- **Original Project:** https://github.com/coreybutler/nvm-windows
- **Node.js Official:** https://nodejs.org/
- **NPM Documentation:** https://docs.npmjs.com/

---

**Version:** 1.2.2  
**Author:** Faran.ali  
**Key Features:** 
- 7z extraction support for smaller file sizes
- Windows 10 optimized
- Simplified single-script installation

