#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Mac Terminal Settings Restoration Script
# Restores ZSH, Oh My ZSH, and terminal settings from a backup

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Helper: ensure a command exists, else error out
ensure_command_exists() {
  local cmd=$1
  local install_hint=$2
  if ! command -v "$cmd" &> /dev/null; then
    echo -e "${RED}Error: '$cmd' is not installed${NC}"
    echo "Install with: $install_hint"
    exit 1
  fi
}

# Verify prerequisites
ensure_command_exists brew '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
ensure_command_exists gh 'brew install gh && gh auth login'

# Backup source directory
BACKUP_DIR="$HOME/Developer/Mac-Setting/Configs"

# Clone backup repo if missing
if [ ! -d "$BACKUP_DIR" ]; then
  echo -e "${YELLOW}Backup directory not found at $BACKUP_DIR${NC}"
  echo "Cloning repository..."
  mkdir -p "$HOME/Developer"
  cd "$HOME/Developer"
  gh repo clone sheepnir/Mac-Setting
  if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${RED}Failed to clone repository or unexpected directory structure${NC}"
    exit 1
  fi
  echo -e "${GREEN}Repository cloned successfully${NC}"
fi

echo -e "${GREEN}=== Restoration Script ===${NC}"
echo "Restoring settings from: $BACKUP_DIR"
echo

# Restore ZSH configs
restore_zsh_configs() {
  echo -e "${YELLOW}Restoring ZSH configuration...${NC}"
  for file in .zshrc .zprofile; do
    if [ -f "$HOME/$file" ]; then
      cp "$HOME/$file" "$HOME/${file}.bak"
      echo "Backed up existing $file to $file.bak"
    fi
  done
  for file in .zshrc .zprofile .zshenv .zlogin .zlogout; do
    if [ -f "$BACKUP_DIR/zsh/$file" ]; then
      cp "$BACKUP_DIR/zsh/$file" "$HOME/"
      echo "✓ $file restored"
    fi
  done
}

# Install or verify Oh My ZSH
install_oh_my_zsh() {
  echo -e "${YELLOW}Ensuring Oh My ZSH...${NC}"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "✓ Oh My ZSH installed"
  else
    echo "Oh My ZSH already present"
  fi
}

# Restore Oh My ZSH custom files
restore_oh_my_zsh_custom() {
  echo -e "${YELLOW}Restoring Oh My ZSH custom...${NC}"
  local custom_dir="$HOME/.oh-my-zsh/custom"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${RED}Oh My ZSH not installed; skipping${NC}"
    return
  fi
  if [ -d "$custom_dir" ]; then
    cp -a "$custom_dir" "${custom_dir}.bak"
    echo "Backed up existing custom directory"
    rm -rf "$custom_dir"
    mkdir -p "$custom_dir"
  fi
  if [ -d "$BACKUP_DIR/oh-my-zsh/custom" ]; then
    cp -R "$BACKUP_DIR/oh-my-zsh/custom/"* "$custom_dir/"
    echo "✓ Custom themes and plugins restored"
  else
    echo -e "${RED}No custom directory in backup${NC}"
  fi
}

# Restore Terminal and iTerm2 preferences
restore_terminal_prefs() {
  echo -e "${YELLOW}Restoring Terminal preferences...${NC}"
  if [ -f "$BACKUP_DIR/terminal/com.apple.Terminal.plist" ]; then
    cp "$BACKUP_DIR/terminal/com.apple.Terminal.plist" "$HOME/Library/Preferences/"
    echo "✓ Terminal.app prefs restored"
  fi
  if [ -f "$BACKUP_DIR/terminal/com.googlecode.iterm2.plist" ]; then
    cp "$BACKUP_DIR/terminal/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"
    echo "✓ iTerm2 prefs restored"
  fi
  echo "Restarting Terminal and iTerm2..."
  killall Terminal || true
  killall iTerm2   || true
}

# Run main tasks
echo -e "${GREEN}Starting restoration...${NC}"
restore_zsh_configs
install_oh_my_zsh
restore_oh_my_zsh_custom
restore_terminal_prefs

# Apply Brewfile if present
if [ -f "$BACKUP_DIR/Brewfile" ]; then
  echo -e "${YELLOW}Applying Brewfile...${NC}"
  brew bundle --file="$BACKUP_DIR/Brewfile"
  echo "✓ Brewfile applied"
fi

echo -e "${GREEN}=== Restoration Complete ===${NC}"
echo "Restart your terminal or run 'exec zsh' to load new settings."
exit 0
