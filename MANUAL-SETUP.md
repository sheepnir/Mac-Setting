# Manual Setup Guide - macOS Tahoe

Complete step-by-step manual instructions for setting up your Mac without using automated scripts. Follow this guide if you prefer to understand and control each installation step.

## Table of Contents

1. [Phase 1: Bootstrap](#phase-1-bootstrap)
2. [Phase 2: Basic Settings](#phase-2-basic-settings)
3. [Phase 3: Development Environment](#phase-3-development-environment)

---

## Phase 1: Bootstrap

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

### Step 2: Install 1Password

1Password is a password manager and will be used to secure credentials.

```bash
# Install 1Password app
brew install --cask 1password

# Install 1Password CLI
brew install 1password-cli

# Verify installation
op --version
```

**Authenticate with 1Password:**

```bash
# Sign in to 1Password
eval $(op signin)

# Follow the prompts to enter your 1Password credentials
# This creates a secure session for CLI access
```

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

GitHub CLI (gh) allows you to interact with GitHub from the terminal.

```bash
# Install GitHub CLI
brew install gh

# Verify installation
gh --version
```

**Authenticate with GitHub:**

```bash
# Start authentication
gh auth login

# Choose your login method (HTTPS or SSH)
# Recommended: HTTPS for simplicity
# Follow the prompts:
# 1. What is your preferred protocol? → HTTPS
# 2. Authenticate Git with your GitHub credentials? → yes
# 3. How would you like to authenticate GitHub CLI? → Login with a web browser
# 4. Follow the web browser prompts

# Verify authentication
gh auth status
```

### Step 5: Clone Mac-Setting Repository

This repository contains all your configurations and setup scripts.

```bash
# Create Developer directory
mkdir -p ~/Developer

# Navigate to it
cd ~/Developer

# Clone the repository
git clone https://github.com/sheepnir/Mac-Setting.git

# Navigate into it
cd Mac-Setting

# Verify the clone
ls -la
# Should show: Scripts/, Configs/, README.md, etc.
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
