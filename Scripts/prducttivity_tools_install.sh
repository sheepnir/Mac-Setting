#!/bin/bash

# Install productivity tools using Homebrew
brew install --cask google-chrome
brew install --cask brave-browser
brew install --cask visual-studio-code
brew install --cask slack
brew install --cask firefox
brew install --cask raycast
brew install --cask bartender
brew install --cask appcleaner
# brew install --cask aldente
brew install --cask grammarly
brew install --cask sublime-text
brew install --cask chatgpt
brew install --cask claude
brew install duti
brew install --cask sublime-text
brew install --cask hiddenbar
brew install --cask defaultbrowser

# Set Sublime Text as the default text editor
duti -s com.sublimetext.4 public.plain-text all
duti -s com.sublimetext.4 public.unix-executable all
duti -s com.sublimetext.4 public.source-code all

# Set Google Chrome as the default browser
defaultbrowser chrome

echo "Productivity tools have been installed successfully!"
echo "Google Chrome has been set as the default browser."
echo "Sublime Text has been set as the default text editor."
