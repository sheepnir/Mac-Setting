#!/bin/bash

set -e

# Check if Homebrew is installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install 1Password
echo "Installing 1Password..."
brew install --cask 1password

# Install 1Password CLI
echo "Installing 1Password CLI..."
brew install 1password-cli

# Install Git
echo "Installing Git..."
brew install git

# Configure Git user
echo "Configuring Git user name and email..."
git config --global user.name "Nir Sheep"
git config --global user.email "sheep.nir@gmail.com"

# Install GitHub CLI
echo "Installing GitHub CLI..."
brew install gh

echo ""
echo "✅ Installation complete."
echo ""
echo "👉 Next steps to authenticate GitHub CLI:"
echo ""
echo "1. Run: gh auth login"
echo "2. Select GitHub.com"
echo "3. Choose 'HTTPS' for protocol"
echo "4. Authenticate using your browser"
echo ""
echo "Optional: If you want to authenticate with SSH keys:"
echo " - Run: gh auth login --hostname github.com --git-protocol ssh"
echo ""
