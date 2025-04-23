# Post-Installation Mac Setup Guide

This guide will walk you through the essential steps for setting up your Mac after a clean installation of macOS. We'll focus on configuring Finder settings, installing essential tools, and restoring your backed-up configurations.

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

Install 1Password to securely access your passwords, including GitHub credentials:

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

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}✓${NC} Oh My Zsh installed"
fi

# Restore ZSH configuration
echo -e "${YELLOW}Restoring ZSH configuration...${NC}"
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak.$(date +%Y%m%d)
    echo -e "${GREEN}✓${NC} Backed up existing .zshrc"
fi

cp "$BACKUP_DIR/zsh/.zshrc" ~/ && echo -e "${GREEN}✓${NC} Restored .zshrc"
cp "$BACKUP_DIR/zsh/.zprofile" ~/ 2>/dev/null && echo -e "${GREEN}✓${NC} Restored .zprofile"
cp "$BACKUP_DIR/zsh/.zshenv" ~/ 2>/dev/null && echo -e "${GREEN}✓${NC} Restored .zshenv"
cp "$BACKUP_DIR/zsh/.zlogin" ~/ 2>/dev/null && echo -e "${GREEN}✓${NC} Restored .zlogin"
cp "$BACKUP_DIR/zsh/.zlogout" ~/ 2>/dev/null && echo -e "${GREEN}✓${NC} Restored .zlogout"

# Restore Oh My Zsh customizations
if [ -d "$BACKUP_DIR/oh-my-zsh/custom" ]; then
    echo -e "${YELLOW}Restoring Oh My Zsh customizations...${NC}"
    
    if [ -d ~/.oh-my-zsh ]; then
        if [ -d ~/.oh-my-zsh/custom ]; then
            mv ~/.oh-my-zsh/custom ~/.oh-my-zsh/custom.bak.$(date +%Y%m%d)
            echo -e "${GREEN}✓${NC} Backed up existing Oh My Zsh custom directory"
        fi
        
        mkdir -p ~/.oh-my-zsh/custom
        cp -R "$BACKUP_DIR/oh-my-zsh/custom/"* ~/.oh-my-zsh/custom/ 2>/dev/null
        echo -e "${GREEN}✓${NC} Restored Oh My Zsh custom files"
    else
        echo -e "${RED}✗${NC} Oh My Zsh not found, skipping custom files restoration"
    fi
fi

# Restore Terminal settings
echo -e "${YELLOW}Restoring Terminal settings...${NC}"

# Terminal.app
if [ -f "$BACKUP_DIR/terminal/com.apple.Terminal.plist" ]; then
    if [ -f ~/Library/Preferences/com.apple.Terminal.plist ]; then
        cp ~/Library/Preferences/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist.bak
        echo -e "${GREEN}✓${NC} Backed up existing Terminal preferences"
    fi
    
    cp "$BACKUP_DIR/terminal/com.apple.Terminal.plist" ~/Library/Preferences/
    echo -e "${GREEN}✓${NC} Restored Terminal preferences"
fi

# iTerm2
if [ -f "$BACKUP_DIR/terminal/com.googlecode.iterm2.plist" ]; then
    if [ -f ~/Library/Preferences/com.googlecode.iterm2.plist ]; then
        cp ~/Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist.bak
        echo -e "${GREEN}✓${NC} Backed up existing iTerm2 preferences"
    fi
    
    cp "$BACKUP_DIR/terminal/com.googlecode.iterm2.plist" ~/Library/Preferences/
    echo -e "${GREEN}✓${NC} Restored iTerm2 preferences"
fi

# VS Code Terminal
if [ -d "$BACKUP_DIR/terminal/vscode" ]; then
    mkdir -p "$HOME/Library/Application Support/Code/User"
    cp "$BACKUP_DIR/terminal/vscode/settings.json" "$HOME/Library/Application Support/Code/User/" 2>/dev/null
    echo -e "${GREEN}✓${NC} Restored VS Code Terminal settings"
fi

# Apply changes
echo -e "${YELLOW}Applying changes...${NC}"
defaults read com.apple.Terminal >/dev/null 2>&1
defaults read com.googlecode.iterm2 >/dev/null 2>&1

echo
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}           Restore Complete!            ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo
echo -e "Your ZSH and terminal settings have been restored."
echo -e "Please restart your terminal to apply all changes."
echo
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/restore_zsh_settings.sh

# Run the script
~/Developer/setup-scripts/restore_zsh_settings.sh
```

## Step 7: Install Basic Utilities

Let's install some essential utilities:

```bash
# Create a utilities installation script
cat > ~/Developer/setup-scripts/install_utilities.sh << 'EOF'
#!/bin/bash

# Install utilities using Homebrew
brew install --cask warp
brew install --cask google-chrome
brew install --cask brave-browser
brew install --cask visual-studio-code
brew install --cask slack
brew install --cask zoom

# Install defaultbrowser to set default browser
brew install --cask defaultbrowser
defaultbrowser brave

echo "Utilities have been installed successfully!"
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/install_utilities.sh

# Run the script
~/Developer/setup-scripts/install_utilities.sh
```

## Conclusion

You've now completed the essential setup of your Mac after a clean installation. Your system is configured with:

1. Customized Finder settings
2. Homebrew package manager
3. 1Password for secure credential management
4. GitHub CLI for repository access
5. Your backed-up ZSH and terminal configurations
6. Essential utility applications

This provides a solid foundation for your development environment. You can now proceed with installing additional tools and configurations specific to your workflow.

To ensure all changes take effect, it's recommended to restart your Mac or at least restart your terminal.

## Next Steps (Optional)

Consider these additional setup steps:

1. Installing productivity tools (Microsoft Office, Sublime Text, etc.)
2. Setting up development environments (Python, Node.js, Docker, etc.)
3. Configuring Git with your personal information
4. Setting up SSH keys for secure connections
5. Customizing your Dock layout

You can create additional scripts for these tasks as needed or handle them in separate setup guides.