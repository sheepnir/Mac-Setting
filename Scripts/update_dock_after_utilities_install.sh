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
dockutil --add /Applications/Warp.app
dockutil --add /Applications/Google\ Chrome.app
dockutil --add /Applications/Brave\ Browser.app
dockutil --add /System/Applications/Messages.app
dockutil --add /System/Applications/App\ Store.app
dockutil --add /System/Applications/System\ Settings.app
dockutil --add /Applications/Slack.app
dockutil --add /Applications/Visual\ Studio\ Code.app
dockutil --add /Applications/ChatGPT.app

# Add Downloads folder to Dock
dockutil --add ~/Downloads --view fan --display folder

# Restart Dock to apply changes
killall Dock

echo "Dock has been successfully updated!"