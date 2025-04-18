# MacBook -  Basic Setup Guide

This guide provides step-by-step instructions for wiping and reinstalling a clean version of macOS Sonoma on your MacBook Pro M3 Max with 36 GB of RAM.

## Before You Begin

- Ensure your MacBook is connected to a power source throughout this process.
- Make sure you have a stable internet connection.

## Step 1: Back Up Your Data

1. Connect an external hard drive to your MacBook.
2. Open Time Machine from System Settings.
3. Select your external drive as the backup disk.
4. Click "Back Up Now" and wait for the process to complete.

## Step 2: Sign Out of Apple Services

1. Open the Apple menu and go to System Settings.
2. Click on your Apple ID at the top.
3. Scroll down and click "Sign Out".
4. Follow the prompts to turn off Find My Mac.

## Step 3: Erase Your MacBook

1. Restart your MacBook and immediately press and hold the power button until you see the startup options.
2. Select "Options" and click "Continue".
3. Choose a language if prompted.
4. Select "Disk Utility" and click "Continue".
5. In Disk Utility, select "Macintosh HD" in the sidebar.
6. Click "Erase" at the top of the window.
7. Name: Macintosh HD
   Format: APFS
   Scheme: GUID Partition Map
8. Click "Erase".
9. If you have other internal volumes, repeat steps 5-8 for each.
10. Once done, close Disk Utility.

## Step 4: Reinstall macOS Sonoma

1. In the macOS Recovery window, select "Reinstall macOS Sonoma".
2. Click "Continue" and follow the on-screen instructions.
3. Select "Macintosh HD" as the installation destination.
4. Wait for the installation to complete. Your Mac may restart several times.

## Step 5: Set Up Your Mac

1. Once the installation is complete, your Mac will restart.
2. Follow the setup assistant to configure your new macOS installation.
3. Choose whether to restore from your Time Machine backup or set up as a new Mac.

## Step 6: Verify and Update

1. Once setup is complete, check System Settings > General > Software Update to ensure you have the latest version of macOS Sonoma.
2. Install any available updates.

## Step 7: Configure Finder Settings

After completing the clean install and initial setup, you can configure your Finder settings using a custom script:

1. Open Terminal and create a folder Developer in the home folder:
   ```
   mkdir -p ~/Developer
   ```

2. Create a Setup Scripts folder:
   ```
   mkdir -p ~/Developer/setup-scripts
   ```

3. Copy the `setup_finder.sh` script from your backups to this folder, or create a new file:
   ```
   cd ~/Developer/setup-scripts
   nano setup_finder.sh
   ```
   
4. Paste the Finder setup script:
   ```bash
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
   ```

5. Save (Ctrl+X, then Y, then Enter) and make the script executable:
   ```
   chmod +x setup_finder.sh
   ```

6. Run the script:
   ```
   ./setup_finder.sh
   ```

## Step 8: Install Homebrew

1. Open Terminal and run:
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Follow the prompts in the Terminal. For Apple Silicon Macs, add Homebrew to your PATH:
   ```
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

3. Verify the installation:
   ```
   brew --version
   ```

## Step 9: Install 1Password

1. In Terminal, run:
   ```
   brew install --cask 1password
   ```

2. Launch 1Password and sign in to your account.

## Step 10: Install and Configure Oh My Zsh

1. Navigate to your setup scripts folder:
   ```
   cd ~/Developer/setup-scripts
   ```

2. Create the setup_ohmyzsh.sh script:
   ```
   nano setup_ohmyzsh.sh
   ```

3. Paste the Oh My Zsh setup script:
   ```bash
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
   ```

4. Save and make the script executable:
   ```
   chmod +x setup_ohmyzsh.sh
   ```

5. Run the script:
   ```
   ./setup_ohmyzsh.sh
   ```

## Step 11: Install Core Utilities

1. Navigate to your setup scripts folder:
   ```
   cd ~/Developer/setup-scripts
   ```

2. Create the utilities_install.sh script:
   ```
   nano utilities_install.sh
   ```

3. Paste the utilities installation script:
   ```bash
   #!/bin/bash

   # Install utilities using Homebrew
   brew install --cask warp
   brew install --cask google-chrome
   brew install --cask brave-browser
   brew install --cask chatgpt
   brew install --cask visual-studio-code
   brew install --cask slack
   brew install --cask zoom


   # Set Brave as the default browser
   brew install --cask defaultbrowser
   defaultbrowser brave

   echo "Utilities have been installed successfully!"
   ```

4. Save and make the script executable:
   ```
   chmod +x utilities_install.sh
   ```

5. Run the script:
   ```
   ./utilities_install.sh
   ```

## Step 12: Install Productivity Tools

1. First, install duti:
   ```
   brew install duti
   ```

2. Navigate to your setup scripts folder:
   ```
   cd ~/Developer/setup-scripts
   ```

3. Create the productivity_tools_install.sh script:
   ```
   nano productivity_tools_install.sh
   ```

4. Paste the productivity tools installation script:
   ```bash
   #!/bin/bash

   # Install productivity tools using Homebrew
   brew install --cask firefox
   # brew install --cask evernote
   # brew install --cask raycast
   brew install --cask bartender
   brew install --cask appcleaner
   brew install --cask aldente
   brew install --cask grammarly
   brew install --cask sublime-text
   brew install --cask microsoft-word
   brew install --cask microsoft-excel
   brew install --cask microsoft-powerpoint


   # Set Sublime Text as the default text editor
   duti -s com.sublimetext.4 public.plain-text all
   duti -s com.sublimetext.4 public.unix-executable all
   duti -s com.sublimetext.4 public.source-code all

   echo "Productivity tools have been installed successfully!"
   echo "Brave has been set as the default browser."
   echo "Sublime Text has been set as the default text editor."
   ```

5. Save and make the script executable:
   ```
   chmod +x productivity_tools_install.sh
   ```

6. Run the script:
   ```
   ./productivity_tools_install.sh
   ```

This completes the basic setup of your MacBook Pro M3 Max. After completing these steps, your system will be ready for installing and configuring the development environment as outlined in the Development Environment Setup Guide.