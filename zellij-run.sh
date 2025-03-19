#!/usr/bin/env sh

# Default pane name
pane_name="Command Output"
command_string=""
c_flag_used=false

# Parse options
while getopts ":n:c:h" opt; do
    case $opt in
    n) pane_name="$OPTARG" ;;
    c)
        command_string="$OPTARG"
        c_flag_used=true
        ;;
    h)
        echo "Usage: $0 [-n pane_name] [-c 'commands to run'] ['commands to run']"
        echo "Options:"
        echo "  -n NAME    Set custom pane name (default: 'Command Output')"
        echo "  -c CMD     Specify command to run (bash -c compatibility)"
        echo "  -h         Show this help message"
        exit 0
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    :)
        echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
    esac
done

# Shift to remove the options
shift $((OPTIND - 1))

# If -c wasn't used and there are remaining arguments, use them as the command
if [ "$c_flag_used" = false ] && [ $# -gt 0 ]; then
    command_string="$*"
fi

# Check if any command was provided
if [ -z "$command_string" ]; then
    echo "Error: No command specified."
    echo "Usage: $0 [-n pane_name] [-c 'commands to run'] ['commands to run']"
    exit 1
fi

# Check if zellij is running
if [ -n "$ZELLIJ" ]; then
    # Zellij is running, use zellij run
    zellij run -c --name "$pane_name" -- bash -c "$command_string"
else
    # Zellij is not running, fall back to regular bash
    bash -c "$command_string"
fi
