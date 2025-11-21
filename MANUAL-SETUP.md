# Manual Setup Guide - macOS Tahoe

Complete step-by-step manual instructions for setting up your Mac without using automated scripts. Follow this guide if you prefer to understand and control each installation step.

## Table of Contents

0. [Pre-Installation: Backup & Clean Install](#pre-installation-backup--clean-install)
1. [Phase 1: Bootstrap](#phase-1-bootstrap)
2. [Phase 2: Basic Settings](#phase-2-basic-settings)
3. [Phase 3: Development Environment](#phase-3-development-environment)

---

## Pre-Installation: Backup & Clean Install

### Before You Begin

If you're starting with an existing Mac that you want to wipe clean and reinstall macOS Tahoe, follow these steps. If you already have a clean macOS Tahoe installation, skip to [Phase 1: Bootstrap](#phase-1-bootstrap).

### Step 1: Backup Your Existing Mac

**Using Time Machine (Recommended):**

```bash
# Connect external drive (500GB+ recommended)
# Open System Settings → General → Time Machine
# Click "Add Backup Disk" and select your external drive
# Wait for backup to complete (may take several hours)
```

**Backup your configurations to this repository:**

```bash
# Navigate to this repository
cd ~/Developer/Mac-Setting

# Create backup directory structure
mkdir -p Configs/zsh
mkdir -p Configs/oh-my-zsh/custom
mkdir -p Configs/terminal
mkdir -p Configs/apps

# Backup ZSH configs
cp ~/.zshrc Configs/zsh/ 2>/dev/null || true
cp ~/.zprofile Configs/zsh/ 2>/dev/null || true
cp ~/.zshenv Configs/zsh/ 2>/dev/null || true

# Backup Oh My Zsh customizations
if [ -d ~/.oh-my-zsh/custom ]; then
    cp -R ~/.oh-my-zsh/custom/* Configs/oh-my-zsh/custom/ 2>/dev/null || true
fi

# Backup Terminal preferences
cp ~/Library/Preferences/com.apple.Terminal.plist Configs/terminal/ 2>/dev/null || true

# Backup VS Code settings
if [ -d "$HOME/Library/Application Support/Code/User" ]; then
    mkdir -p Configs/apps/vscode
    cp "$HOME/Library/Application Support/Code/User/settings.json" Configs/apps/vscode/ 2>/dev/null || true
fi

# Backup Homebrew packages list
if command -v brew &> /dev/null; then
    brew bundle dump --file=Configs/Brewfile 2>/dev/null || true
fi

# Create backup metadata
cat > Configs/backup-metadata.txt << EOF
# Backup Date: $(date)
# macOS Version: $(sw_vers -productVersion)
# System Model: $(system_profiler SPHardwareDataType 2>/dev/null | grep "Model Identifier" | awk '{print $3}')
# Hostname: $(hostname)
EOF

echo "✓ Configurations backed up to Configs/ directory"
```

**Push backup to GitHub:**

```bash
# Commit your backup
cd ~/Developer/Mac-Setting
git add Configs/
git commit -m "Backup configuration before clean install"
git push origin main

echo "✓ Backup pushed to GitHub"
```

### Step 2: Prepare for Clean Installation

**Sign out of Apple services:**

```bash
# Sign out of iCloud
# 1. System Settings → Apple ID
# 2. Scroll down and click "Sign Out"
# 3. When prompted about Find My Mac, choose your preference
# 4. Wait for sign-out to complete

# Sign out of Messages (if used)
# 1. Open Messages
# 2. Messages menu → Settings → Accounts
# 3. Select your account and click "Sign Out"

# Deauthorize Music/iTunes (if used)
# 1. Open Music
# 2. Account menu → Authorizations → Deauthorize This Computer
```

**Disconnect external drives:**

```bash
# Safely eject all external drives
# Drag drives to trash, or use Terminal:
diskutil eject /Volumes/DriveNameHere

# Verify they're disconnected
diskutil list
```

### Step 3: Boot into Recovery Mode

```bash
# Shut down your Mac
# Hold power button for 10 seconds, select "Shut Down"

# Power on and immediately hold Command (⌘) + R
# Keep holding until you see Apple logo or progress bar
# Wait for Recovery Mode to load (may take 5-10 minutes)
```

### Step 4: Erase Your Drive

In Recovery Mode:

```bash
# In Disk Utility (should open automatically):
# 1. Select "Macintosh HD" in sidebar
# 2. Click "Erase" button
# 3. Set options:
#    Name: Macintosh HD
#    Format: APFS
#    Scheme: GUID Partition Map
# 4. Click "Erase"
# 5. Wait for completion
```

### Step 5: Reinstall macOS Tahoe

In Recovery Mode after erase:

```bash
# 1. Utilities menu → Reinstall macOS (or similar)
# 2. Click "Continue"
# 3. Accept license
# 4. Select "Macintosh HD" as destination
# 5. Click "Install"
# 6. Wait for completion (20-40 minutes)
# 7. Mac will restart multiple times - DO NOT INTERRUPT
```

### Step 6: Complete Setup Assistant

After installation:

```bash
# 1. Follow Setup Assistant prompts
# 2. Choose language and keyboard
# 3. Connect to WiFi
# 4. Sign in with Apple ID (optional but recommended)
# 5. Create user account
# 6. When asked about data restoration:
#    - Choose "Don't transfer information now"
#    - Or restore from Time Machine backup
# 7. Complete setup

# Verify clean installation
sw_vers
# Should show macOS 26.x (Tahoe)
```

### Step 7: Get This Repository

Your new Mac is now clean. Get this setup repository:

```bash
# Open Terminal
# Create Developer directory
mkdir -p ~/Developer

# Clone this repository
cd ~/Developer
git clone https://github.com/sheepnir/Mac-Setting.git

# Navigate into it
cd Mac-Setting

# If you pushed a backup, pull your backed-up configs
git pull origin main

# Verify clone
ls -la
```

### You're Ready!

Your Mac is now clean and ready. Continue to **Phase 1: Bootstrap** below.

---

## Phase 1: Bootstrap

**Overview:** In this phase, you'll install the essential tools needed to set up your Mac. By the end, you'll have this repository cloned and ready to use for Phases 2 and 3.

**What you'll install:**
- Homebrew (macOS package manager)
- 1Password (password manager with CLI)
- Git (version control)
- GitHub CLI (GitHub access from terminal)
- Mac-Setting repository (these setup scripts)

**Before you start:**
- Have your 1Password account credentials ready
- Have your GitHub account login ready
- Ensure you have internet connectivity
- Plan for 15-20 minutes

---

### Step 1: Install Homebrew

Homebrew is the macOS package manager. It's the foundation for installing everything else.

```bash
# Open Terminal (Applications > Utilities > Terminal)

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Follow the prompts and enter your password when asked
# Installation takes 5-10 minutes
```

**Add Homebrew to your PATH (Apple Silicon Macs):**

```bash
# Add to your shell profile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# Apply immediately
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**Verify installation:**

```bash
brew --version
# Should show: Homebrew X.X.X

brew doctor
# Should show: Your system is ready to brew.
```

### Step 2: Install & Configure 1Password

1Password is a password manager. You'll use it to securely store credentials and authenticate from the command line.

```bash
# Install 1Password app
brew install --cask 1password

# Install 1Password CLI (command-line tool)
brew install 1password-cli

# Verify installation
op --version
# Should show: 2.X.X or similar
```

**Launch 1Password app and sign in:**

The app needs to be configured before the CLI can work:

```bash
# Open 1Password app from Applications
open -a "1Password 7"
# or
open -a "1Password 8"
# or just open Applications and click 1Password
```

When 1Password opens:
1. Click "Sign in" (or similar button)
2. Enter your **1Password account email**
3. Enter your **1Password master password**
4. If prompted for 2FA, complete the authentication
5. Wait for 1Password to fully load
6. Keep 1Password running in the background (you can minimize it)

**Verify 1Password is accessible:**

```bash
# Check if 1Password app is running
pgrep "1Password" | head -1
# Should return a process ID

# Or check if you can see the menu bar icon
# Look for "🔐" or "1P" in the top menu bar
```

**Sign in with 1Password CLI:**

Now that the app is running, you can authenticate the CLI:

```bash
# Sign in to 1Password CLI
eval $(op signin)

# You should see output like:
# export OP_SESSION_my_account=xxxxx
# (This creates an encrypted session token)
```

**Verify CLI authentication:**

```bash
# Check that you're authenticated
op whoami
# Should return your 1Password account information

# Test that you can access your vault
op vault list
# Should show your 1Password vaults
```

**Keep 1Password Running:**

The 1Password CLI needs the 1Password app to be running. You can:
- Keep it open in the background
- It will auto-lock after inactivity (you can unlock with your password)
- Close and reopen as needed

### Step 3: Install Git & Configure

Git is version control software. You'll use it to clone this repository.

```bash
# Install Git
brew install git

# Verify installation
git --version
```

**Configure Git with your user information:**

```bash
# Set your name (change to your actual name if desired)
git config --global user.name "Nir Sheep"

# Set your email (change to your actual email if desired)
git config --global user.email "sheep.nir@gmail.com"

# Verify configuration
git config --global user.name
git config --global user.email
```

### Step 4: Install GitHub CLI

GitHub CLI (gh) allows you to interact with GitHub from the terminal and clone repositories securely.

```bash
# Install GitHub CLI
brew install gh

# Verify installation
gh --version
# Should show: gh version X.X.X
```

### Step 5: Authenticate with GitHub

You need to log in to your GitHub account to clone repositories. GitHub CLI makes this easy and secure.

**Start the authentication process:**

```bash
# Start GitHub authentication
gh auth login
```

**Follow these prompts:**

```
? What is your preferred protocol for Git operations on this host? (SSH/HTTPS)
  → Select: HTTPS (simpler, password-based)
  → Press Enter

? Authenticate Git with your GitHub credentials? (Y/n)
  → Select: Y (yes)
  → Press Enter

? How would you like to authenticate GitHub CLI?
  → Select: Login with a web browser
  → Press Enter
```

**Complete authentication in your web browser:**

1. A browser window will open automatically
2. Click "Authorize github-cli" (or similar button)
3. You may need to enter your GitHub password
4. If you have 2FA enabled, follow those prompts
5. Return to Terminal - authentication is complete!

**Verify authentication:**

```bash
# Check that you're logged in
gh auth status

# Should show something like:
# Logged in to github.com as your-username
# - Active account: yes
# - Git operations protocol: https
# - Token: gists, read:org, repo, workflow
```

### Step 6: Clone Mac-Setting Repository

Now that you're authenticated, you can clone this repository and get all the setup scripts.

**Create project directory and clone:**

```bash
# Create Developer directory (standard location)
mkdir -p ~/Developer

# Navigate to it
cd ~/Developer

# Clone the Mac-Setting repository
git clone https://github.com/sheepnir/Mac-Setting.git

# Navigate into the cloned repository
cd Mac-Setting

# Verify the clone was successful
ls -la
```

**You should see:**

```
ARCHIVE/
Configs/
GenAI/
Python_Setup/
Scripts/
README.md
MANUAL-SETUP.md
PRE-INSTALLATION.md
POST-INSTALL-STEPS.md
DEVELOPMENT-SETUP.md
... (other files)
```

**Verify your Git configuration is correct:**

```bash
# Check that Git is properly configured
git config --global user.name
# Should show: Nir Sheep

git config --global user.email
# Should show: sheep.nir@gmail.com

# Check that you can access the repository
git remote -v
# Should show GitHub URLs for origin

# Check that you're on the main branch
git branch
# Should show: * main
```

**Congratulations!**

You now have:
- ✅ Homebrew installed (package manager)
- ✅ 1Password installed (password manager)
- ✅ Git configured (version control)
- ✅ GitHub CLI authenticated (GitHub access)
- ✅ Mac-Setting repository cloned (setup scripts and guides)

You're ready to proceed with Phase 2!

---

### Troubleshooting GitHub Authentication

**Problem: "Not authenticated with GitHub"**

```bash
# Re-run authentication
gh auth login

# Or check status
gh auth status
```

**Problem: "Permission denied when cloning"**

```bash
# Make sure you're authenticated
gh auth status

# If not authenticated, run:
gh auth login

# Then try cloning again
git clone https://github.com/sheepnir/Mac-Setting.git
```

**Problem: "Already logged in but need different account"**

```bash
# Log out first
gh auth logout

# Then log back in with new account
gh auth login
```

**Problem: "2FA (Two-Factor Authentication) errors"**

When prompted for authentication:
1. 2FA code is sent to your phone or authenticator app
2. Enter the code when prompted in the browser
3. Then authorize the GitHub CLI

If you don't have 2FA set up on GitHub:
- This flow is simpler (just enter password when prompted)
- Consider enabling 2FA later for security

**Problem: "Clone failed - repository not found"**

```bash
# Make sure you're using the correct URL
# It should be: https://github.com/sheepnir/Mac-Setting.git

# Check that you're authenticated
gh auth status

# Try cloning with correct URL
git clone https://github.com/sheepnir/Mac-Setting.git
```

---

## Phase 2: Basic Settings

### Step 1: Configure Terminal & ZSH

ZSH is the modern shell for macOS. We'll set it up with Oh My Zsh framework.

```bash
# Check current shell
echo $SHELL
# Should show: /bin/zsh (default on Tahoe)

# Check ZSH version
zsh --version
# Should show: zsh 5.8 or newer
```

#### Install Oh My Zsh

```bash
# Download and run Oh My Zsh installer
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# When prompted to change shell to zsh, press Y (yes)
# This will close and reopen your terminal

# Verify installation
ls -la ~/.oh-my-zsh
```

#### Configure ZSH Theme & Plugins

```bash
# Edit your ZSH configuration
nano ~/.zshrc

# Find this line (around line 11):
# ZSH_THEME="robbyrussell"

# Change it to:
# ZSH_THEME="half-life"

# Find this line (around line 77):
# plugins=(git)

# Change it to:
# plugins=(git macos web-search)

# Save and exit: Ctrl+O, Enter, Ctrl+X
```

**Apply changes:**

```bash
# Reload your shell configuration
exec zsh

# Your prompt should now show the "half-life" theme with custom styling
```

#### Restore Backed-up ZSH Configs (Optional)

If you have backed-up configs from your old Mac:

```bash
# Copy backed-up configs
cp ~/Developer/Mac-Setting/Configs/zsh/.zshrc ~/.zshrc
cp ~/Developer/Mac-Setting/Configs/zsh/.zprofile ~/.zprofile

# Reload
exec zsh
```

### Step 2: Configure Finder

Set Finder to show useful information and use list view.

```bash
# Set list view as default
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

# Show hidden files (starts with a dot)
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar at bottom
defaults write com.apple.Finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.Finder ShowStatusBar -bool true

# Show toolbar
defaults write com.apple.Finder ShowToolbar -bool true

# Set search scope to current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# New Finder windows show Downloads folder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Restart Finder to apply changes
killall Finder
```

### Step 3: Customize Dock

The Dock is your taskbar with quick app access.

```bash
# Install dockutil (tool to manage dock)
brew install dockutil

# Clear all Dock items
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

# Add apps to Dock
dockutil --add /Applications/Safari.app
dockutil --add /Applications/Finder.app
dockutil --add /Applications/Messages.app
dockutil --add /Applications/FaceTime.app
dockutil --add /Applications/System\ Settings.app
dockutil --add /Applications/Phone.app
dockutil --add /Applications/Notes.app
dockutil --add /Applications/Reminders.app
dockutil --add /Applications/App\ Store.app

# Add Applications folder (list view)
dockutil --add ~/Applications --view list --sort name

# Add Downloads folder (fan view)
dockutil --add ~/Downloads --view fan --sort dateadded

# Restart Dock
killall Dock
```

**Manual Dock Configuration (Alternative):**

If you prefer to customize the Dock manually:

1. Open System Settings
2. Click "Dock & Menu Bar"
3. Drag apps to/from the Dock
4. Reorder by dragging
5. Remove by dragging out

### Step 4: Install Productivity Tools

Install essential applications for productivity.

```bash
# Browsers
brew install --cask google-chrome
brew install --cask brave-browser
brew install --cask firefox

# Editors & IDEs
brew install --cask visual-studio-code
brew install --cask sublime-text

# Communication
brew install --cask slack

# AI & Utilities
brew install --cask chatgpt
brew install --cask raycast
brew install --cask bartender
brew install --cask appcleaner
brew install --cask hiddenbar
brew install --cask grammarly

# Set Chrome as default browser
brew install duti
duti -s com.google.Chrome com.apple.CoreServices.AnyApplication all

# Set Sublime Text as default text editor
duti -s com.sublimetext.3 public.plain-text all
```

**Verify installation:**

```bash
# Check apps are installed
ls /Applications | grep -E "Chrome|VS Code|Slack"

# Open an app to verify
open -a "Google Chrome"
```

---

## Phase 3: Development Environment

### Step 1: Install Python & Essential Packages

Python is the programming language. We'll install it with essential data science packages.

```bash
# Install Python
brew install python

# Verify installation
python3 --version
# Should show: Python 3.11+

# Upgrade pip
pip3 install --upgrade pip
```

**Install Core Scientific Packages:**

```bash
# Data manipulation and analysis
pip3 install numpy pandas matplotlib seaborn scikit-learn

# Interactive notebooks
pip3 install jupyter

# Install each package
pip3 install numpy
pip3 install pandas
pip3 install matplotlib
pip3 install seaborn
pip3 install scikit-learn
pip3 install jupyter
```

**Install AI/ML Packages:**

These packages enable machine learning and AI work. They're large and take time to download.

```bash
# Deep learning frameworks (large downloads, take time)
pip3 install torch              # PyTorch (optional - very large)
pip3 install tensorflow         # TensorFlow (optional - very large)

# NLP and transformers
pip3 install transformers
pip3 install nltk
pip3 install spacy
pip3 install gensim

# API clients for AI services
pip3 install anthropic          # Anthropic (Claude)
pip3 install openai             # OpenAI (ChatGPT)

# Utilities
pip3 install python-dotenv      # Environment variables
pip3 install requests           # HTTP requests
```

**Verify Python packages:**

```bash
# List all installed packages
pip3 list | grep -E "numpy|pandas|jupyter|torch"

# Test import
python3 -c "import numpy; print(numpy.__version__)"
```

### Step 2: Create a Virtual Environment

Virtual environments keep project dependencies isolated.

```bash
# Create a virtual environment for a project
python3 -m venv ~/my_project

# Activate it
source ~/my_project/bin/activate

# You'll see (my_project) in your prompt

# Install packages in the environment
pip install requests pandas

# Deactivate when done
deactivate
```

### Step 3: Install Docker Desktop

Docker lets you run applications in isolated containers.

```bash
# Install Docker Desktop
brew install --cask docker

# Verify installation (Docker needs to be running)
docker --version

# Start Docker Desktop
# Open Applications > Docker
# Wait for Docker to initialize (appears in menu bar)
```

**Test Docker:**

```bash
# Make sure Docker.app is running first
# Open Applications > Docker

# Test with hello-world
docker run hello-world

# You should see: "Hello from Docker!"
```

**Install Docker Compose:**

Docker Compose comes with Docker Desktop on macOS. Verify it's installed:

```bash
docker compose version

# Should show: Docker Compose version X.X.X
```

### Step 4: Install Ollama (Local LLM Runtime)

Ollama lets you run large language models locally without cloud services.

```bash
# Install Ollama
brew install ollama

# Verify installation
ollama --version
```

**Start Ollama server:**

```bash
# Start Ollama in the background
ollama serve &

# Or run it in foreground (will occupy terminal)
ollama serve
```

**Download a model:**

```bash
# In another terminal (if running in foreground), download a model
# Lightweight option (2.7 GB)
ollama pull mistral

# Or medium option (3.8 GB)
ollama pull llama2

# Check downloaded models
ollama list
```

**Test Ollama:**

```bash
# Chat with a model
ollama run mistral

# In the chat, type:
# > Hello! How are you?

# The model will respond
# Press Ctrl+D or type 'exit' to quit
```

### Step 5: Setup Open WebUI (Web Interface for Ollama)

Open WebUI provides a web interface for your local LLMs.

```bash
# Make sure Ollama is running
ollama serve &

# In another terminal, start Open WebUI with Docker
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  ghcr.io/open-webui/open-webui:latest

# Open your web browser
# Visit: http://localhost:3000

# Create an account and login
# Select your model from the dropdown
# Start chatting!
```

---

## Verification Checklist

### Phase 1: Bootstrap

After Phase 1, verify:

```bash
# Check Homebrew
brew --version

# Check 1Password
op --version

# Check Git
git config --global user.name
git config --global user.email

# Check GitHub CLI
gh auth status

# Check repository
ls ~/Developer/Mac-Setting/Scripts
```

### Phase 2: Basic Settings

After Phase 2, verify:

```bash
# Check ZSH
echo $SHELL
# Should output: /bin/zsh

# Check Oh My Zsh
grep "^ZSH_THEME=" ~/.zshrc
# Should show: ZSH_THEME="half-life"

# Check Finder is in list view
defaults read com.apple.Finder FXPreferredViewStyle
# Should output: Nlsv

# Check hidden files are shown
defaults read com.apple.finder AppleShowAllFiles
# Should output: 1

# Check Dock has apps
defaults read com.apple.dock persistent-apps | head -20
```

### Phase 3: Development

After Phase 3, verify:

```bash
# Check Python
python3 --version
pip3 list | grep numpy

# Check Docker
docker --version
docker run hello-world

# Check Ollama
ollama --version
ollama list

# Test Python
python3 -c "import numpy; print('NumPy works!')"

# Test virtual environment
python3 -m venv test_env
source test_env/bin/activate
pip install requests
python3 -c "import requests; print('Virtual env works!')"
deactivate
rm -rf test_env
```

---

## Customization Options

### Change ZSH Theme

Available themes: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

```bash
# Edit .zshrc
nano ~/.zshrc

# Change this line:
ZSH_THEME="half-life"

# To one of these:
ZSH_THEME="robbyrussell"      # Default classic theme
ZSH_THEME="agnoster"          # Shows git branch info
ZSH_THEME="dracula"           # Dark and moody
ZSH_THEME="spaceship"         # Feature-rich

# Save and reload
exec zsh
```

### Add ZSH Plugins

```bash
# Edit .zshrc
nano ~/.zshrc

# Change plugins line:
plugins=(git macos web-search)

# Add more:
plugins=(git macos web-search docker docker-compose pip history)

# Save and reload
exec zsh
```

### Customize Dock Further

```bash
# Remove all items
defaults delete com.apple.dock persistent-apps

# Add specific apps
dockutil --add /Applications/MyApp.app

# List current Dock items
dockutil --list

# Remove an item
dockutil --remove "App Name"

# Restart Dock
killall Dock
```

### Create Aliases in Terminal

```bash
# Edit .zshrc
nano ~/.zshrc

# Add aliases at the end:
alias ll='ls -laG'
alias python='python3'
alias pip='pip3'
alias d='docker'
alias dc='docker compose'
alias venv='python3 -m venv'

# Save and reload
exec zsh

# Now you can use: ll, python, pip, d, dc, venv
```

---

## Common Manual Setup Scenarios

### Scenario 1: Only Want Basic Setup (No Development Tools)

Skip Phase 3 and just do Phase 1 & 2:

```bash
# Phase 1: Bootstrap
brew install --cask 1password
brew install 1password-cli
brew install git
brew install gh
# Clone repo

# Phase 2: Basic Settings
# Run the ZSH, Finder, Dock, and app installation steps above

# You'll have a clean, organized Mac with productivity tools
```

### Scenario 2: Already Have Homebrew & Git Installed

Skip those steps in Phase 1 and start from 1Password:

```bash
# Just verify they exist
brew --version
git --version

# Then continue with 1Password and GitHub CLI
brew install --cask 1password
brew install 1password-cli
brew install gh
```

### Scenario 3: Want Minimal Python Setup

Skip the large ML packages:

```bash
# Install Python
brew install python

# Install just core packages
pip3 install numpy pandas matplotlib jupyter

# Skip torch, tensorflow, transformers (very large)

# You'll have Python for data analysis without the large frameworks
```

### Scenario 4: Don't Want Docker

Skip Docker installation completely:

```bash
# Just do Phase 1 & 2
# And Phase 3 without the Docker steps

# You'll have Python and Ollama without containers
```

### Scenario 5: Want Only Ollama (No Python ML)

```bash
# Phase 1: Bootstrap (all steps)

# Phase 2: Basic Settings (all steps)

# Phase 3: Skip Python packages, just do Ollama

# You'll have local LLM capability without ML frameworks
```

---

## Troubleshooting Manual Setup

### Homebrew Issues

```bash
# Check Homebrew health
brew doctor

# Fix common issues
brew cleanup
brew update

# If stuck, uninstall and reinstall
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Git Configuration

```bash
# Check current config
git config --global --list

# Change config
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Verify
git config --global user.name
```

### ZSH Theme Not Appearing

```bash
# Reload ZSH
exec zsh

# Or source the config
source ~/.zshrc

# Check Oh My Zsh is installed
ls ~/.oh-my-zsh

# If missing, reinstall:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Python Package Installation Fails

```bash
# Upgrade pip first
pip3 install --upgrade pip

# Try again
pip3 install package_name

# If still fails, try with specific version
pip3 install package_name==1.0.0

# Check what's installed
pip3 show package_name
```

### Docker Won't Start

```bash
# Open Docker app from Applications
open -a Docker

# Wait 30 seconds for initialization

# Check if running
docker ps

# If still fails, try:
# 1. Quit Docker (Cmd+Q)
# 2. Wait 10 seconds
# 3. Open Docker again
```

### Ollama Connection Issues

```bash
# Make sure Ollama server is running
ollama serve &

# In another terminal, test connection
ollama list

# If no response, try:
# 1. Kill ollama: killall ollama
# 2. Wait 5 seconds
# 3. Start again: ollama serve &
```

---

## Getting Help

If you get stuck during manual setup:

1. **Check the automation scripts** - They contain working commands you can reference
2. **Read POST-INSTALL-STEPS.md** - Has verification and troubleshooting
3. **Check DEVELOPMENT-SETUP.md** - Deep dive into each tool
4. **Visit official documentation:**
   - Homebrew: https://brew.sh
   - Git: https://git-scm.com/doc
   - Oh My Zsh: https://ohmyz.sh
   - Python: https://python.org
   - Docker: https://docs.docker.com
   - Ollama: https://ollama.ai

---

## Notes on Manual vs. Automated Setup

**Advantages of Manual Setup:**
- ✅ You learn exactly what each tool does
- ✅ You can skip tools you don't need
- ✅ You understand potential issues better
- ✅ Full control over configurations

**Advantages of Automated Setup (Scripts):**
- ✅ Faster - runs all steps automatically
- ✅ Less chance of typos or mistakes
- ✅ Consistent results
- ✅ Easy to repeat on new Macs

**Recommendation:** Start with the automation scripts for consistency, then manually customize afterwards based on your preferences.

---

**Happy manual setup!** Take your time and verify each step. 🚀
