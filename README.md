
# zellij-run

A bash utility script that wraps commands in Zellij panes when available, with graceful fallback to regular bash execution.

## Overview

```zellij-run``` allows you to execute bash commands either in a new [Zellij](https://zellij.dev) pane or with regular bash if Zellij isn't available. It's designed as a drop-in replacement for ```bash -c``` that automatically leverages Zellij's pane system when possible.

## Features

- Run commands in a new Zellij pane when inside a Zellij session
- Gracefully fall back to regular bash execution when Zellij isn't available
- Compatible with ```bash -c``` syntax for easy integration with other tools
- Customizable pane naming
- Works correctly with detached Zellij sessions

## Installation

### Manual Installation

1. Save the script to a directory in your PATH:

```bash
# Create ~/bin if it doesn't exist
mkdir -p ~/bin

# Download the script
curl -o ~/bin/zellij-run https://raw.githubusercontent.com/yetisage/zellij-run/refs/heads/main/zellij-run
# or manually create and paste the script content

# Make it executable
chmod +x ~/bin/zellij-run

# Add to PATH if needed (for bash)
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

### Using Homebrew (macOS)

```bash
# Install using homebrew
brew tap yetisage/scripts ~/homebrew-tap
brew install zellij-run
```

## Usage

### Basic Usage

```bash
# Run a simple command
zellij-run 'echo "Hello World"'

# Run multiple commands
zellij-run 'ls -la && echo "Done listing files"'

# Using -c flag (bash -c compatibility)
zellij-run -c 'find . -name "*.txt"'
```

### With Custom Pane Name

```bash
# Set a custom pane name
zellij-run -n "File Search" 'find . -name "*.txt"'

# Combined with -c flag
zellij-run -n "System Status" -c 'top -b -n 1'
```

## Options

| Option | Description |
|--------|-------------|
| ```-c 'command'``` | Specify the command to run (bash -c compatibility) |
| ```-n 'name'``` | Set a custom pane name (default: "Command Output") |
| ```-h``` | Display help information |

## Integration Examples

### k9s Plugin

```yaml
k9s:
  plugins:
    podlogs:
      shortCut: Shift-L
      description: "Pod logs in Zellij"
      scopes:
        - pods
      command: zellij-run
      args:
        - -n
        - "Pod: $NAME"
        - -c
        - "kubectl logs $NAME -n $NAMESPACE -f"
```

## Behavior

1. **Inside Active Zellij Session**: Creates a new pane with your command
2. **Detached Zellij Sessions**: Falls back to regular bash execution
3. **No Zellij Available**: Executes command with standard bash

## Troubleshooting

If you encounter issues:

- Ensure Zellij is properly installed (```zellij --version```)
- Check if the script is executable (```chmod +x path/to/zellij-run```)
- Verify the script is in your PATH (```which zellij-run```)
- For pane creation issues, make sure you're in an active Zellij session (```echo $ZELLIJ```)

## License

This script is released under the GNU General Public License v3.0 (GPL-3.0).

---

Feel free to contribute improvements or report issues!

