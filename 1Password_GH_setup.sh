#!/bin/bash
set -e
# Install Homebrew if missing
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update and install tools
brew update
brew install --cask 1password
brew install 1password-cli
brew install git
git config --global user.name "Nir Sheep"
git config --global user.email "sheep.nir@gmail.com"
brew install gh
