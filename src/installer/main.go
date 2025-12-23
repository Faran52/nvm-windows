package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"golang.org/x/sys/windows/registry"
)

func main() {
	fmt.Println("=== NVM for Windows Installer ===")
	fmt.Println("Version: 1.2.2")
	fmt.Println("")

	// Get install directory
	var installDir string
	if len(os.Args) > 1 {
		installDir = os.Args[1]
	} else {
		// Default location
		localAppData := os.Getenv("LOCALAPPDATA")
		installDir = filepath.Join(localAppData, "nvm")
	}

	fmt.Printf("Installing to: %s\n", installDir)

	// Get symlink directory
	var symlinkDir string
	if len(os.Args) > 2 {
		symlinkDir = os.Args[2]
	} else {
		symlinkDir = `C:\nvm4w\nodejs`
	}

	fmt.Printf("Creating symlink at: %s\n", symlinkDir)
	fmt.Println("")

	// Create directories
	if err := os.MkdirAll(installDir, 0755); err != nil {
		fmt.Printf("Error creating install directory: %v\n", err)
		os.Exit(1)
	}

	// Set environment variables
	if err := setEnvironmentVariable("NVM_HOME", installDir); err != nil {
		fmt.Printf("Error setting NVM_HOME: %v\n", err)
	} else {
		fmt.Println("✓ Set NVM_HOME environment variable")
	}

	if err := setEnvironmentVariable("NVM_SYMLINK", symlinkDir); err != nil {
		fmt.Printf("Error setting NVM_SYMLINK: %v\n", err)
	} else {
		fmt.Println("✓ Set NVM_SYMLINK environment variable")
	}

	// Update PATH
	if err := updatePath(installDir, symlinkDir); err != nil {
		fmt.Printf("Error updating PATH: %v\n", err)
	} else {
		fmt.Println("✓ Updated PATH environment variable")
	}

	fmt.Println("")
	fmt.Println("Installation complete!")
	fmt.Println("")
	fmt.Println("Next steps:")
	fmt.Println("1. Close and reopen your terminal/PowerShell")
	fmt.Println("2. Run 'nvm --version' to verify installation")
	fmt.Println("3. Run 'nvm install latest' to install Node.js")
}

// setEnvironmentVariable sets a system-wide environment variable
func setEnvironmentVariable(name, value string) error {
	k, err := registry.OpenKey(registry.LOCAL_MACHINE,
		`SYSTEM\CurrentControlSet\Control\Session Manager\Environment`,
		registry.WRITE)
	if err != nil {
		return err
	}
	defer k.Close()

	return k.SetStringValue(name, value)
}

// updatePath adds NVM directories to the PATH environment variable
func updatePath(nvmHome, nvmSymlink string) error {
	k, err := registry.OpenKey(registry.LOCAL_MACHINE,
		`SYSTEM\CurrentControlSet\Control\Session Manager\Environment`,
		registry.READ|registry.WRITE)
	if err != nil {
		return err
	}
	defer k.Close()

	path, _, err := k.GetStringValue("Path")
	if err != nil {
		return err
	}

	// Add NVM_HOME and NVM_SYMLINK to PATH if not already there
	pathEntries := strings.Split(path, ";")
	nvmHomeVar := "%NVM_HOME%"
	nvmSymlinkVar := "%NVM_SYMLINK%"

	hasNvmHome := false
	hasNvmSymlink := false

	for _, entry := range pathEntries {
		if entry == nvmHomeVar {
			hasNvmHome = true
		}
		if entry == nvmSymlinkVar {
			hasNvmSymlink = true
		}
	}

	newPath := path
	if !hasNvmHome {
		newPath = newPath + ";" + nvmHomeVar
	}
	if !hasNvmSymlink {
		newPath = newPath + ";" + nvmSymlinkVar
	}

	// Clean up double semicolons
	newPath = strings.ReplaceAll(newPath, ";;", ";")

	return k.SetStringValue("Path", newPath)
}

// Check if we have admin rights
func init() {
	if !isRunningAsAdmin() {
		fmt.Println("ERROR: This installer must be run as Administrator!")
		fmt.Println("Please right-click and select 'Run as administrator'")
		os.Exit(1)
	}
}

// isRunningAsAdmin checks if the process is running with admin privileges
func isRunningAsAdmin() bool {
	_, err := os.Open("\\\\.\\PHYSICALDRIVE0")
	return err == nil
}
