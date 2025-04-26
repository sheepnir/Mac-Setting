#!/bin/bash

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set the theme
sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="half-life"/' ~/.zshrc

# Set the plugins
sed -i '' 's/plugins=(git)/plugins=(git macos web-search)/' ~/.zshrc

# Source the updated .zshrc file
source ~/.zshrc

echo "Oh My Zsh has been installed and configured!"