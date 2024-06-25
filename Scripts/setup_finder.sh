#!/bin/bash

# Set Finder view to List
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

# Sort by Date Added
defaults write com.apple.Finder FXArrangeGroupViewBy -string "dateAdded"

# Show toolbar
defaults write com.apple.Finder ShowToolbar -bool true

# Show path bar
defaults write com.apple.Finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.Finder ShowStatusBar -bool true

# Show hidden files
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Set sidebar items
defaults write com.apple.finder sidebar-items -dict-add \
    AirDrop -dict-add ShowInSidebar -bool true \
    Applications -dict-add ShowInSidebar -bool true \
    Desktop -dict-add ShowInSidebar -bool true \
    Documents -dict-add ShowInSidebar -bool true \
    Downloads -dict-add ShowInSidebar -bool true \
    HomeDirectory -dict-add ShowInSidebar -bool true \
    iCloud -dict-add ShowInSidebar -bool true \
    NetworkDiskMode -dict-add ShowInSidebar -bool true

# Uncheck all tags in sidebar
defaults write com.apple.finder ShowRecentTags -bool false

# New Finder windows show Downloads
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Restart Finder to apply changes
killall Finder

echo "Finder preferences have been updated successfully!"