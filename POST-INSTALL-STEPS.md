# Post-Installation Steps & Verification Guide

Detailed guide for verifying and customizing your Mac after each installation phase.

## Table of Contents

1. [After Phase 1: Bootstrap](#after-phase-1-bootstrap)
2. [After Phase 2: Basic Settings](#after-phase-2-basic-settings)
3. [After Phase 3: Development](#after-phase-3-development)
4. [System Health Checks](#system-health-checks)
5. [Customization Guide](#customization-guide)

---

## ✅ After Phase 1: Bootstrap

**Duration:** 10-15 minutes

### What Phase 1 Installed

- ✅ Homebrew (package manager)
- ✅ 1Password (app + CLI)
- ✅ Git (version control)
- ✅ GitHub CLI (gh command)
- ✅ Mac-Setting repository cloned to `~/Developer/Mac-Setting`

### Verification Checklist

#### 1. Verify Homebrew Installation

```bash
# Check Homebrew version and location
brew --version

# Expected output: Homebrew X.X.X

# Check Homebrew health
brew doctor

# Should show: Your system is ready to brew.
```

#### 2. Verify 1Password Installation

```bash
# Check 1Password app is installed
ls -la /Applications/1Password\ 7.app 2>/dev/null || \
ls -la /Applications/1Password\ 8.app 2>/dev/null || \
ls -la /Applications/1Password.app

# Check 1Password CLI
op --version

# Expected output: 2.X.X or similar
```

#### 3. Verify 1Password Authentication

```bash
# Test 1Password CLI access
op whoami

# Should return your account information
# If this fails, authenticate with:
eval $(op signin)
```

#### 4. Verify Git Installation & Configuration

```bash
# Check Git version
git --version

# Check Git configuration
git config --global user.name
git config --global user.email

# Should show:
# Nir Sheep
# sheep.nir@gmail.com
```

#### 5. Verify GitHub CLI

```bash
# Check GitHub CLI version
gh --version

# Check authentication status
gh auth status

# If not authenticated, run:
gh auth login
```

#### 6. Verify Repository Cloned

```bash
# Check if Mac-Setting repo exists
ls -la ~/Developer/Mac-Setting/

# Should show:
# - Scripts/ directory
# - Configs/ directory
# - GenAI/ directory
# - Python_Setup/ directory
# - README.md and other docs
```

### What to Do Next

```bash
# When Phase 1 verification is complete, run Phase 2:
~/Developer/Mac-Setting/Scripts/phase-2-basic-settings.sh
```

### Troubleshooting Phase 1

| Issue | Solution |
|-------|----------|
| Homebrew installation stuck | Kill (Ctrl+C) and run again after 5 mins |
| 1Password CLI auth fails | Run `eval $(op signin)` to re-authenticate |
| GitHub CLI auth fails | Run `gh auth login` and follow prompts |
| Repository already exists | That's okay! It will update. Continue to Phase 2. |

---

## ⚙️ After Phase 2: Basic Settings

**Duration:** 20-30 minutes
**Customizations Applied:**
- ✅ Terminal & ZSH configuration
- ✅ Finder preferences and sidebar
- ✅ Dock layout with apps and folders
- ✅ Oh My Zsh framework with theme
- ✅ Productivity tools installed

### Verification Checklist

#### 1. Verify Terminal & ZSH

```bash
# Check ZSH is default shell
echo $SHELL

# Should output: /bin/zsh

# Check ZSH version
zsh --version

# Should show: zsh 5.8 or newer
```

#### 2. Verify Oh My Zsh Installation

```bash
# Check Oh My Zsh directory exists
ls -la ~/.oh-my-zsh

# Check ZSH theme
grep "^ZSH_THEME=" ~/.zshrc

# Should show: ZSH_THEME="half-life"
```

#### 3. Verify ZSH Plugins are Loaded

```bash
# Check plugins in .zshrc
grep "^plugins=" ~/.zshrc

# Should show plugins including: git, macos, web-search
```

#### 4. Verify Finder Preferences

```bash
# Check Finder is in list view
defaults read com.apple.Finder FXPreferredViewStyle

# Should output: Nlsv

# Check hidden files are shown
defaults read com.apple.finder AppleShowAllFiles

# Should output: 1 (means true)
```

#### 5. Verify Dock Customization

```bash
# Check Dock apps
defaults read com.apple.dock persistent-apps

# Should show list of apps like Safari, Finder, etc.

# Verify Dock visually:
# - Click Apple menu (top-left)
# - Select Dock in menu bar
# - Your customized apps should appear
```

#### 6. Verify Installed Applications

Test that key apps installed in Phase 2 are accessible:

```bash
# Check Chrome installed
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version

# Check VS Code installed
/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron --version

# Check Slack installed
ls -la /Applications/Slack.app

# Open any of these to verify they launch:
open -a "Google Chrome"
open -a "Visual Studio Code"
open -a "Slack"
```

#### 7. Test Terminal Theme

```bash
# Your prompt should show the "half-life" theme
# It should display with the distinctive styling

# Try these ZSH features:
# Type a command and notice the theme styling
# Press Tab for autocomplete
# Type `git status` and see git plugin info

# If theme doesn't show, reload:
exec zsh
```

#### 8. Verify Raycast Installation

```bash
# Check if Raycast installed
ls -la /Applications/Raycast.app

# Open Raycast with spotlight:
# Open Raycast app from Applications
# Or press Cmd+Space and type "Raycast"
```

### System Restart Recommendation

After Phase 2 (especially if Dock and Finder changed):

```bash
# Restart your Mac to ensure all settings take effect
# Method 1: Via terminal
sudo shutdown -r now

# Method 2: Apple menu → Restart
```

### What to Do Next

```bash
# When Phase 2 verification is complete, run Phase 3:
~/Developer/Mac-Setting/Scripts/phase-3-development.sh
```

### Troubleshooting Phase 2

| Issue | Solution |
|-------|----------|
| Finder changes didn't apply | Run `killall Finder` then check again |
| ZSH theme not showing | Run `exec zsh` to reload shell |
| Dock didn't update | Run `killall Dock` then check System Settings |
| Apps won't open | Check App Store for installer or run `brew install app-name --cask` |

---

## 🛠️ After Phase 3: Development

**Duration:** 30-45 minutes
**Components Installed:**
- ✅ Python with dev tools
- ✅ Docker Desktop
- ✅ Docker Compose
- ✅ Ollama (local LLM runtime)
- ✅ Open WebUI (LLM web interface)
- ✅ Essential Python packages

### Verification Checklist

#### 1. Verify Python Installation

```bash
# Check Python version
python3 --version

# Should show: Python 3.11+ or newer

# Check pip
pip3 --version

# Check python3 in PATH
which python3

# Should show: /opt/homebrew/bin/python3 (or similar)
```

#### 2. Verify Essential Python Packages

```bash
# Check installed packages
pip3 list | grep -E "numpy|pandas|matplotlib|jupyter"

# You should see:
# - numpy
# - pandas
# - matplotlib
# - jupyter
# - scikit-learn
# - torch
# - tensorflow
# (and others as specified)
```

#### 3. Test Python Development Environment

```bash
# Create a test virtual environment
python3 -m venv ~/test_env

# Activate it
source ~/test_env/bin/activate

# Install a test package
pip install requests

# Verify installation
python3 -c "import requests; print(requests.__version__)"

# Deactivate when done
deactivate

# Clean up
rm -rf ~/test_env
```

#### 4. Verify Docker Installation

```bash
# Check Docker version
docker --version

# Should show: Docker version XX.XX.XX

# Check Docker daemon is running
docker ps

# If error "Cannot connect to Docker daemon", open Docker.app

# Test Docker with hello-world
docker run hello-world

# Expected: Prints welcome message and "Hello from Docker!"
```

#### 5. Verify Docker Compose

```bash
# Check Docker Compose version
docker compose version

# Should show: Docker Compose version X.X.X
```

#### 6. Verify Ollama Installation

```bash
# Check if Ollama is installed
which ollama

# Should show: /opt/homebrew/bin/ollama (or /usr/local/bin/ollama)

# Check Ollama version
ollama --version

# Should show: ollama version X.X.X
```

#### 7. Download and Test an Ollama Model

This step may take 5-15 minutes depending on model size and internet speed:

```bash
# Start Ollama (if not running in background)
ollama serve &

# In a new terminal, pull a lightweight model
ollama pull mistral

# Once downloaded, test the model
ollama run mistral "What is 2+2?"

# Expected: The AI model responds with "4"

# To stop, press Ctrl+C
```

### Testing Ollama with Open WebUI

```bash
# Once Ollama is running, start Open WebUI
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  ghcr.io/open-webui/open-webui:latest

# Open web browser and go to:
# http://localhost:3000

# Create account and test the interface
# Select mistral model and chat with it

# To stop: docker stop <container-id>
```

#### 8. Verify AI/ML Packages

```bash
# Test PyTorch
python3 -c "import torch; print(f'PyTorch: {torch.__version__}'); print(f'CUDA: {torch.cuda.is_available()}')"

# Test TensorFlow
python3 -c "import tensorflow as tf; print(f'TensorFlow: {tf.__version__}')"

# Test scikit-learn
python3 -c "import sklearn; print(f'scikit-learn: {sklearn.__version__}')"

# Test Jupyter
python3 -c "import jupyter; print(f'Jupyter installed')"
```

### Create a Test Project

```bash
# Create project directory
mkdir ~/test_ml_project
cd ~/test_ml_project

# Create virtual environment
python3 -m venv venv

# Activate
source venv/bin/activate

# Create a test notebook
pip install jupyter
jupyter notebook

# This opens Jupyter in your browser
# Create a new notebook and test:
# - Import numpy, pandas, torch
# - Run some simple calculations
# - Verify everything works

# Close notebook (Ctrl+C) and deactivate
deactivate
```

### Verify System Performance

```bash
# Check available disk space
df -h

# Should have 30GB+ free after installation

# Check RAM usage
top -l 1 | head -20

# Docker should use reasonable resources
docker stats
```

### What to Do Next

After Phase 3, your Mac is fully configured! Optional next steps:

1. **Configure VS Code for Python:**
   - Open VS Code
   - Install "Python" extension
   - Set Python interpreter to your preferred environment

2. **Create Your First Project:**
   ```bash
   mkdir ~/my_project
   cd ~/my_project
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt  # if you have one
   ```

3. **Start Using Ollama:**
   - Keep ollama running: `ollama serve`
   - Access via terminal: `ollama run model_name`
   - Access via web UI: `http://localhost:3000`

4. **Push Repo Changes:**
   ```bash
   cd ~/Developer/Mac-Setting
   git add -A
   git commit -m "Completed Phase 3 installation"
   git push origin main
   ```

### Troubleshooting Phase 3

| Issue | Solution |
|-------|----------|
| Docker won't start | Open Docker.app from Applications, wait for initialization |
| Ollama model download fails | Check internet connection, try smaller model |
| Python package import fails | Install it: `pip3 install package_name` |
| Docker "permission denied" | Ensure Docker Desktop is running and initialized |
| Ollama connection refused | Make sure to run `ollama serve` first |
| Open WebUI won't load | Check Docker is running, wait 20-30 seconds for container to start |
| Port 3000 already in use | Use different port: `-p 3001:8080` |

---

## 🔍 System Health Checks

### Regular Maintenance Commands

```bash
# Check disk usage
brew doctor

# Update Homebrew
brew update

# Upgrade all packages
brew upgrade

# Clean up old downloads
brew cleanup

# Remove unused Docker images
docker image prune -a

# Remove unused Docker volumes
docker volume prune
```

### Monthly Tasks

```bash
# Update macOS
System Settings → General → Software Update

# Update VS Code
Open VS Code → Code menu (if on Mac) → Check for Updates

# Update Python packages
pip3 install --upgrade pip
pip3 install --upgrade -r requirements.txt
```

---

## 🎨 Customization Guide

### Customize Your Terminal Theme

Edit `~/.zshrc` and change:

```bash
# Find this line:
ZSH_THEME="half-life"

# Change to your preferred theme:
ZSH_THEME="robbyrussell"      # Classic simple theme
ZSH_THEME="agnoster"          # Shows git branch beautifully
ZSH_THEME="dracula"           # Dark and moody
ZSH_THEME="spaceship"         # Feature-rich with lots of info

# Save and reload
exec zsh
```

Available themes: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

### Add More ZSH Plugins

Edit `~/.zshrc` and find the plugins line:

```bash
# Current:
plugins=(git macos web-search)

# Add more plugins:
plugins=(git macos web-search docker docker-compose pip history)

# Save and reload
exec zsh
```

Available plugins: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins

### Customize Your Dock

Edit `Scripts/update_dock.sh` to change which apps appear:

```bash
# The script uses dockutil
dockutil --add /Applications/App\ Name.app

# Then re-run the script or manually in Terminal
```

Or customize graphically:
- Right-click Dock separator
- Select "Dock Preferences"
- Drag apps to reorder
- Drag apps out to remove

### Customize Finder Sidebar

System Settings → Sidebar (or Finder → Settings)
- Toggle which folders appear
- Drag to reorder
- Remove tags if desired

### Add Custom Alias in Terminal

Edit `~/.zshrc` and add:

```bash
# At the end of the file:
alias ll='ls -laG'
alias python='python3'
alias pip='pip3'
alias d='docker'
alias dc='docker compose'
alias myproject='cd ~/my_project && source venv/bin/activate'

# Save and reload
exec zsh
```

### Create Custom ZSH Function

Add to `~/.zshrc`:

```bash
# Create a Python venv and activate it
mkvenv() {
  python3 -m venv $1
  source $1/bin/activate
}

# Save and reload
exec zsh

# Usage:
# mkvenv my_project
# You're now in the virtual environment
```

### Customize macOS Tahoe UI (New Features)

**Menu Bar Customization:**
- System Settings → Control Center
- Toggle which icons appear in menu bar
- Rearrange icons in Liquid Glass menu bar

**App Icon Tinting:**
- Right-click any app icon
- Select "Options"
- Choose tint: Light, Dark, or Clear

**Folder Customization:**
- Right-click any folder
- Select "Customize Tags..."
- Add colors and emoji

---

## ✨ Performance Tips

### Keep Your System Fast

```bash
# Regular cleanup
brew cleanup
docker system prune

# Remove large Docker images you don't use
docker images
docker rmi image_id

# Monitor system resources
top
htop  # if installed via brew
```

### Optimize Python Projects

```bash
# Remove unused dependencies
pip uninstall package_name

# Keep requirements.txt updated
pip freeze > requirements.txt

# Use virtual environments for all projects
python3 -m venv venv
```

### Docker Best Practices

```bash
# Use .dockerignore to reduce image size
# Use multi-stage builds for smaller images
# Remove stopped containers regularly
docker container prune

# Monitor disk usage
docker system df
```

---

## 📚 Next Resources

- [DEVELOPMENT-SETUP.md](DEVELOPMENT-SETUP.md) - Deep dive into dev tools
- [GenAI/localLLM.md](GenAI/localLLM.md) - Advanced Ollama and LLM setup
- [Python_Setup/setup.md](Python_Setup/setup.md) - Python virtual environments guide

---

**Congratulations!** Your Mac is now fully configured and ready for development! 🎉

For questions or issues, refer back to this guide or check the individual tool documentation.
