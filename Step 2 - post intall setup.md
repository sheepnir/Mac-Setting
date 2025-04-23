# Post-Installation Mac Setup Guide

This guide will walk you through the essential steps for setting up your Mac after a clean installation of macOS. We'll focus on configuring Finder settings, installing essential tools like Homebrew and GitHub CLI, and restoring your backed-up configurations.

## Step 1: Configure Finder Settings

First, let's configure Finder to your preferred settings:

```bash
# Create a setup scripts directory
mkdir -p ~/Developer/setup-scripts

# Create a Finder setup script
cat > ~/Developer/setup-scripts/setup_finder.sh << 'EOF'
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
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/setup_finder.sh

# Run the script
~/Developer/setup-scripts/setup_finder.sh
```

## Step 2: Install Homebrew

Homebrew is a package manager for macOS that simplifies the installation of software:

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to your PATH for Apple Silicon Macs
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Verify installation
brew --version
```

## Step 3: Install 1Password

First, let's install 1Password to securely access your passwords, including GitHub credentials:

```bash
# Install 1Password using Homebrew
brew install --cask 1password

# Launch 1Password
open -a 1Password
```

Sign in to your 1Password account and make sure you can access your passwords.

## Step 4: Install GitHub CLI

Now that 1Password is set up and you can access your credentials, let's install GitHub CLI:

```bash
# Install GitHub CLI
brew install gh

# Authenticate with GitHub
gh auth login
```

Follow the prompts to complete the authentication process. You will typically want to:
- Select GitHub.com (not enterprise)
- Sign in with your web browser
- Authorize the GitHub CLI

## Step 5: Clone Your Backup Repository

Now, let's clone the repository containing your backup files:

```bash
# Create Developer directory if it doesn't exist
mkdir -p ~/Developer

# Clone your backup repository
# Replace 'your-username/mac-backups' with your actual repository
gh repo clone your-username/mac-backups ~/Developer/Mac-Setting

# Verify the backup files exist
ls -la ~/Developer/Mac-Setting/Configs
```

## Step 6: Restore ZSH and Terminal Settings

Now let's restore your ZSH configuration and terminal settings:

```bash
# Create a restore script
cat > ~/Developer/setup-scripts/restore_zsh_settings.sh << 'EOF'
#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Define backup directory
BACKUP_DIR="$HOME/Developer/Mac-Setting/Configs"

# Print header
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}   macOS Terminal & ZSH Restore Script   ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo

# Check if backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${RED}Backup directory not found: $BACKUP_DIR${NC}"
    echo -e "Please make sure your backup files are in the correct location."
    exit 1
fi

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo -e "${