#!/bin/bash

# Install productivity tools using Homebrew
brew install --cask zoom
brew install --cask firefox
brew install --cask evernote
brew install --cask raycast
brew install --cask bartender
brew install --cask appcleaner
brew install --cask aldente
brew install --cask grammarly
brew install --cask sublime-text
brew install --cask microsoft-word
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint

# Set Brave as the default browser
brew install --cask defaultbrowser
defaultbrowser brave

# Set Sublime Text as the default text editor
duti -s com.sublimetext.4 public.plain-text all
duti -s com.sublimetext.4 public.unix-executable all
duti -s com.sublimetext.4 public.source-code all

echo "Productivity tools have been installed successfully!"
echo "Brave has been set as the default browser."
echo "Sublime Text has been set as the default text editor."