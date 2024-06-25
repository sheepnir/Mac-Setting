#!/bin/bash

# Check if dockutil is installed
if ! command -v dockutil &> /dev/null
then
    echo "dockutil is not installed. Please install it first."
    echo "You can install it using Homebrew: brew install dockutil"
    exit 1
fi

# Remove all items from Dock
dockutil --remove all

# Add desired apps to Dock
dockutil --add /System/Applications/Finder.app
dockutil --add /Applications/Safari.app
dockutil --add /System/Applications/System\ Settings.app
dockutil --add /System/Applications/Utilities/Terminal.app
dockutil --add /System/Applications/Messages.app

# Add Applications folder to Dock
dockutil --add /Applications --view grid --display folder

# Add Downloads folder to Dock
dockutil --add ~/Downloads --view fan --display folder

# Set Dock to show only open applications
defaults write com.apple.dock static-only -bool true

# Restart Dock to apply changes
killall Dock

echo "Dock has been successfully configured!"
