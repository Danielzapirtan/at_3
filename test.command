#!/bin/bash

# Ensure Homebrew is available (Apple Silicon path)
eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || \
eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null

# Change to the script's directory
cd "$(dirname "$0")" || exit 1

VER=3.12

main() {
    rootdir=$(pwd)
    
    # Install Python if needed
    if ! command -v python$VER &> /dev/null; then
        brew install python@$VER
    fi
    
    # Create/activate virtual environment
    if [ -z "$VIRTUAL_ENV" ]; then
        [ -d venv ] || python$VER -m venv venv
        source venv/bin/activate
    fi
    
    # Install ffmpeg if needed
    if ! command -v ffmpeg &> /dev/null; then
        brew install ffmpeg
    fi
    
    # Install Python dependencies
    pip install -r requirements.txt
    
    # Run the app
    python$VER app.py
}

main
