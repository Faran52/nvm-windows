package file

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

// Extract7z extracts a 7z archive using the 7z command-line utility
// This function requires 7z to be installed and available in the system PATH
func Extract7z(src, dest string) error {
	// Ensure destination directory exists
	err := os.MkdirAll(dest, 0755)
	if err != nil {
		return fmt.Errorf("failed to create destination directory: %w", err)
	}

	// Check if 7z command is available
	_, err = exec.LookPath("7z")
	if err != nil {
		return fmt.Errorf("7z is not installed or not in PATH: %w", err)
	}

	// Extract the 7z file using command line
	cmd := exec.Command("7z", "x", "-o"+dest, src)
	output, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("failed to extract 7z archive: %v, output: %s", err, string(output))
	}

	return nil
}

func ReadLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}

func Exists(filename string) bool {
	_, err := os.Stat(filename)
	return err == nil
}
