# How to Restore ZSH & Terminal Settings on a New Mac

This guide will walk you through restoring your backed-up ZSH configuration, Oh My Zsh customizations, and terminal settings to a new MacBook.

## Prerequisites

Before you begin, ensure you have:

- The backup files from your old Mac (located in `~/Developer/Mac-Setting/Configs`)
- Administrator access on your new Mac

## Step 1: Install Required Software

First, install the necessary software on your new Mac:

### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the instructions to add Homebrew to your PATH if prompted.

### Install or Update ZSH (Optional, as macOS comes with ZSH by default)

```bash
brew install zsh
```

### Install Oh My Zsh (if you were using it)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install iTerm2 (if you were using it)

```bash
brew install --cask iterm2
```

## Step 2: Copy Your Backup Files to the New Mac

Transfer your backup directory (`~/Developer/Mac-Setting/Configs`) from your old Mac to your new Mac. You can use:

- AirDrop
- External drive
- Cloud storage service (Dropbox, Google Drive, iCloud)
- Direct file transfer over your local network

Place the backup directory in the same location on your new Mac:

```bash
mkdir -p ~/Developer/Mac-Setting
# Now copy your Configs folder to ~/Developer/Mac-Setting/
```

## Step 3: Restore ZSH Configuration Files

Run the following commands to restore your ZSH configuration:

```bash
# Backup any existing configuration first
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.bak.$(date +%Y%m%d)
fi

# Restore your .zshrc and other ZSH config files
cp ~/Developer/Mac-Setting/Configs/zsh/.zshrc ~/
cp ~/Developer/Mac-Setting/Configs/zsh/.zprofile ~/ 2>/dev/null
cp ~/Developer/Mac-Setting/Configs/zsh/.zshenv ~/ 2>/dev/null
cp ~/Developer/Mac-Setting/Configs/zsh/.zlogin ~/ 2>/dev/null
cp ~/Developer/Mac-Setting/Configs/zsh/.zlogout ~/ 2>/dev/null
```

## Step 4: Restore Oh My Zsh Customizations

If you were using Oh My Zsh with custom themes or plugins:

```bash
# Make sure Oh My Zsh is installed first (see Step 1)

# Backup any existing customizations first
if [ -d ~/.oh-my-zsh/custom ]; then
    mv ~/.oh-my-zsh/custom ~/.oh-my-zsh/custom.bak.$(date +%Y%m%d)
    mkdir -p ~/.oh-my-zsh/custom
fi

# Copy all custom themes and plugins
cp -R ~/Developer/Mac-Setting/Configs/oh-my-zsh/custom/* ~/.oh-my-zsh/custom/ 2>/dev/null
```

## Step 5: Restore Terminal Settings

### For Terminal.app

```bash
# Backup existing preferences
if [ -f ~/Library/Preferences/com.apple.Terminal.plist ]; then
    cp ~/Library/Preferences/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist.bak
fi

# Copy terminal preferences
cp ~/Developer/Mac-Setting/Configs/terminal/com.apple.Terminal.plist ~/Library/Preferences/
```

### For iTerm2 (if installed)

```bash
# Backup existing preferences
if [ -f ~/Library/Preferences/com.googlecode.iterm2.plist ]; then
    cp ~/Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist.bak
fi

# Copy iTerm2 preferences
cp ~/Developer/Mac-Setting/Configs/terminal/com.googlecode.iterm2.plist ~/Library/Preferences/
```

### For VS Code Terminal (if applicable)

```bash
mkdir -p "$HOME/Library/Application Support/Code/User"
cp ~/Developer/Mac-Setting/Configs/terminal/vscode/settings.json "$HOME/Library/Application Support/Code/User/" 2>/dev/null
```

## Step 6: Apply Changes

After restoring all settings, you need to apply the changes:

1. For Terminal preferences:
   ```bash
   defaults read com.apple.Terminal
   defaults read com.googlecode.iterm2
   ```

2. Restart Terminal or iTerm2 to apply the new settings.

3. If you see any error messages when starting ZSH, check for path issues or missing referenced files in your `.zshrc`.

## Step 7: Install Additional Dependencies

Your ZSH configuration might reference additional tools or plugins that need to be installed:

1. Check your `.zshrc` for brew packages, npm packages, or other dependencies
2. Install any required fonts (especially if you use Powerline or custom prompts)
3. Install additional plugins mentioned in your ZSH config

## Troubleshooting

### If ZSH Doesn't Start Properly

1. Check the errors in the terminal
2. Try starting ZSH with no config: `zsh -f`
3. Examine your `.zshrc` for issues, particularly path settings or missing referenced files
4. Ensure permissions are correct: `chmod 644 ~/.zshrc`

### If Oh My Zsh Themes Don't Work

1. Verify the theme is properly installed in `~/.oh-my-zsh/themes` or `~/.oh-my-zsh/custom/themes`
2. Check if the theme requires special fonts or symbols
3. Make sure the `ZSH_THEME` setting in your `.zshrc` references the correct theme name

### If Terminal Colors Look Wrong

1. Verify your terminal is set to use 256 colors
2. Check if you need to install additional color schemes
3. For iTerm2, you might need to import color presets manually

## Automated Restore Script

For convenience, you can create an automated restore script. Here's a template:

```bash
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
    echo -e "Please make sure to transfer your backup files from your old Mac first."
    exit 1
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
        echo -e "   Install Oh My Zsh first with:"
        echo -e "   sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
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
```

Save this script as `restore-zsh-settings.sh`, make it executable with `chmod +x restore-zsh-settings.sh`, and run it when needed.

## Conclusion

You've now successfully restored your ZSH configuration and terminal settings to your new Mac. If you encounter any issues, refer to the troubleshooting section or check the original configuration files for any specific requirements or dependencies.

Remember that some paths or references in your configuration files might need to be updated if they point to specific locations on your old Mac.