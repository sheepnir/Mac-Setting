#!/bin/bash

# Set Finder view to List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Sort by Date Added (on Desktop and in Finder windows)
defaults write com.apple.finder DesktopViewSettings -dict-add IconViewSettings -dict-add arrangeBy dateAdded
defaults write com.apple.finder FK_StandardViewSettings -dict-add IconViewSettings -dict-add arrangeBy dateAdded
defaults write com.apple.finder StandardViewSettings -dict-add IconViewSettings -dict-add arrangeBy dateAdded

# Show toolbar
defaults write com.apple.finder ShowToolbar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Hide recent tags in sidebar
defaults write com.apple.finder ShowRecentTags -bool false

# New Finder windows show Downloads
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Restart Finder to apply changes
sleep 1
killall Finder

echo "Finder preferences have been updated successfully!"
