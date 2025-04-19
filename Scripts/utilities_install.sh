#!/bin/bash

# Install utilities using Homebrew
brew install --cask warp
brew install --cask google-chrome
brew install --cask brave-browser
# brew install --cask visual-studio-code
brew install --cask slack
# brew install --cask zoom


# Set Brave as the default browser
brew install --cask defaultbrowser
defaultbrowser brave

echo "Utilities have been installed successfully!"
