# Mac Setup Guide

This guide walks through running the setup scripts in the recommended order to configure a new Mac using your backup repo and utility scripts.

## Execution Order

1. **1Password & GitHub Setup**
   - Manually create the setup script via nano, then run it to install tools.
     ```bash
     nano ~/setup-scripts/1Password_GH_setup.sh
     ```
     Paste the following content into the editor:
     ```bash
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
     ```
     Save (`Ctrl+O`), exit (`Ctrl+X`), then make it executable and run:
     ```bash
     chmod +x ~/setup-scripts/1Password_GH_setup.sh
     ~/setup-scripts/1Password_GH_setup.sh
     ```
     Next, open the 1Password app from Applications and sign in using the GUI.

     Finally, authenticate GitHub CLI:
     ```bash
     gh auth login
     ```

2. **Ensure Backup Repo**
   - Clone your `Mac-Setting` configs to `$HOME/Developer/Mac-Setting`:
   ```bash
   if [ ! -d "$HOME/Developer/Mac-Setting/Configs" ]; then
     mkdir -p "$HOME/Developer"
     cd "$HOME/Developer"
     gh repo clone sheepnir/Mac-Setting
   fi
   ```

   _From here onward, scripts live in `$HOME/Developer/Mac-Setting/Scripts`._

3. **Terminal & Zsh Restoration**
   - Restores Zsh configs, Oh My Zsh custom themes/plugins, Terminal/iTerm2 prefs.
   ```bash
   $HOME/Developer/Mac-Setting/Scripts/terminal_settings.sh
   ```

4. **Finder Preferences**
   - Sets list view, sorts by date added, shows hidden files/extensions, and configures sidebar.
   ```bash
   $HOME/Developer/Mac-Setting/Scripts/setup_finder.sh
   ```

5. **Dock Layout**
   - Installs `dockutil` if missing, clears Dock, adds essential apps, Applications folder (list), Downloads folder (fan).
   ```bash
   $HOME/Developer/Mac-Setting/Scripts/update_dock.sh
   ```

6. **Productivity Tools**
   - Installs browsers (Chrome, Brave, Firefox), editors (VS Code, Sublime), Slack, Raycast, Grammarly, and more.
   ```bash
   $HOME/Developer/Mac-Setting/Scripts/prducttivity_tools_install.sh
   ```

> **Note:** The Python setup script is skipped for now; add it back once core tools are in place.

## Final Steps

- Reload Zsh to apply configs:
  ```bash
  exec zsh
  ```

- Open the 1Password app to ensure it’s signed in.

All set! Your Mac is now configured with your preferred settings and essential tools.

