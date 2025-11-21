# Mac-Setting: macOS Tahoe Setup & Configuration Guide

Complete automation toolkit for setting up a fresh macOS Tahoe installation on Apple Silicon Macs (M3 Max, M4 MacBook Air, etc.).

## Quick Overview

This repository provides a **4-Phase automated setup process** to transform a clean macOS Tahoe installation into a fully configured development environment:

1. **Phase 1: Bootstrap** - Install essentials (Homebrew, 1Password, GitHub CLI, clone this repo)
2. **Phase 2: Basic Settings** - System preferences, terminal, Finder, Dock, productivity apps
3. **Phase 3: Development** - Python, Docker, Docker Compose, Ollama + Open WebUI, LLM tools
4. **Phase 4: Optional** - Parallels Desktop & Windows gaming environment (coming soon)

---

## 🚀 Quick Start

### Before You Begin

- **macOS Tahoe (version 26.x)** installed and fully updated
- Clean installation (or willing to back up existing configurations)
- Administrator access
- Stable internet connection
- External drive for backups (recommended)

### The Installation Flow

```
┌─────────────────────────────────────────┐
│  Clean macOS Tahoe Installation         │
├─────────────────────────────────────────┤
│  Phase 1: Bootstrap                     │
│  Run: phase-1-bootstrap.sh              │
│  ↓ Installs Homebrew, 1Password, GitHub │
│  ↓ Clones this repo                     │
├─────────────────────────────────────────┤
│  Phase 2: Basic Settings                │
│  Run: phase-2-basic-settings.sh         │
│  ↓ Terminal, Finder, Dock, Productivity │
├─────────────────────────────────────────┤
│  Phase 3: Development Environment       │
│  Run: phase-3-development.sh            │
│  ↓ Python, Docker, LLM, AI Tools        │
├─────────────────────────────────────────┤
│  Mac Fully Configured! ✅               │
└─────────────────────────────────────────┘
```

---

## 📋 Phase 1: Bootstrap Installation

**Duration:** ~10-15 minutes

### What Gets Installed
- Homebrew (macOS package manager)
- 1Password (password manager)
- 1Password CLI
- Git & GitHub CLI
- Mac-Setting repository (setup scripts & guides)

### How to Run

Open Terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/sheepnir/Mac-Setting/main/Scripts/phase-1-bootstrap.sh)"
```

Or if you prefer to download and review first:

```bash
# Download the script
curl -o phase-1-bootstrap.sh https://raw.githubusercontent.com/sheepnir/Mac-Setting/main/Scripts/phase-1-bootstrap.sh

# Make it executable
chmod +x phase-1-bootstrap.sh

# Review it
cat phase-1-bootstrap.sh

# Run it
./phase-1-bootstrap.sh
```

### What Happens During Phase 1

1. **Homebrew** - Checks for Homebrew, installs if missing
2. **1Password** - Installs 1Password app and CLI
   - You'll be prompted to open 1Password and sign in
   - Requires: Your 1Password account email & master password
3. **Git & GitHub CLI** - Installs Git and GitHub CLI
   - Configures Git with your user information
4. **GitHub Authentication** - Authenticates with GitHub
   - You'll be prompted to run `gh auth login`
   - Requires: Your GitHub login credentials
   - Browser-based authentication (can use 2FA)
5. **Clone Repository** - Clones Mac-Setting to `~/Developer/Mac-Setting`
6. **Next Steps** - Displays instructions to continue

### Requirements for Phase 1

Before running Phase 1, have these ready:
- ✅ 1Password account email and master password
- ✅ GitHub account username and password (or 2FA device)
- ✅ Internet connection (stable download needed)
- ✅ ~15 minutes of time

### Next Step

Once Phase 1 completes successfully, you'll be prompted to:

```bash
# Run Phase 2
~/Developer/Mac-Setting/Scripts/phase-2-basic-settings.sh
```

---

## ⚙️ Phase 2: Basic Settings & Essential Tools

**Duration:** ~20-30 minutes

### What Gets Configured

**System Settings:**
- Finder: List view, show hidden files, show extensions
- Finder sidebar: Custom layout
- Dock: Custom app arrangement with Applications and Downloads folders
- Terminal: ZSH with Oh My Zsh framework
- Menu bar and Control Center (Tahoe features)

**Applications Installed:**
- Browsers: Google Chrome, Brave
- Editors: VS Code, Sublime Text, Cursor
- Communication: Slack
- AI Tools: ChatGPT, Claude
- Utilities: Raycast, AppCleaner, HiddenBar, Grammarly

### How to Run

```bash
~/Developer/Mac-Setting/Scripts/phase-2-basic-settings.sh
```

### What This Script Does

Automatically runs these in order:
1. Terminal & ZSH setup (restores backed-up configs)
2. Finder preferences
3. Dock customization
4. Oh My Zsh framework installation
5. Productivity tools installation

### After Phase 2 Completes

Your Mac now has:
- ✅ Customized terminal with ZSH and Oh My Zsh
- ✅ Finder in list view with custom sidebar
- ✅ Clean Dock with essential apps
- ✅ All productivity tools installed and ready

**Next step:** Run Phase 3

```bash
~/Developer/Mac-Setting/Scripts/phase-3-development.sh
```

---

## 🛠️ Phase 3: Development Environment

**Duration:** ~30-45 minutes

### What Gets Installed

**Languages & Runtimes:**
- Python (via Homebrew)
- Common Python packages for development
- Node.js (optional)

**Development Tools:**
- Docker Desktop for Mac
- Docker Compose
- Ollama (local LLM runtime)
- Open WebUI (web interface for local LLMs)

**AI & ML Packages:**
- numpy, pandas, matplotlib, seaborn
- scikit-learn, jupyter
- torch (PyTorch)
- tensorflow
- transformers, nltk, spacy, gensim
- anthropic, openai (API clients)
- python-dotenv

### How to Run

```bash
~/Developer/Mac-Setting/Scripts/phase-3-development.sh
```

### Available Commands After Installation

```bash
# Python
python3 --version
pip install package_name

# Create virtual environments
python3 -m venv myenv
source myenv/bin/activate

# Docker
docker --version
docker run hello-world

# Ollama (local LLMs)
ollama pull llama2
ollama run llama2

# Open WebUI (after Ollama)
docker run -d -p 3000:8080 ghcr.io/open-webui/open-webui:latest
# Then visit: http://localhost:3000
```

### After Phase 3 Completes

Your Mac now has a complete development environment with:
- ✅ Python with data science libraries
- ✅ Docker for containerized applications
- ✅ Local LLM capabilities (Ollama)
- ✅ Web UI for interacting with local models
- ✅ All tools for AI/ML development

---

## 📚 Additional Documentation

### For More Details

- **[PRE-INSTALLATION.md](./PRE-INSTALLATION.md)** - Backup and clean install instructions
- **[POST-INSTALL-STEPS.md](./POST-INSTALL-STEPS.md)** - Detailed post-installation verification and customization
- **[DEVELOPMENT-SETUP.md](./DEVELOPMENT-SETUP.md)** - Deep dive into development tools and how to use them

### Configuration Backup

All your backed-up configurations are stored in `/Configs`:
- `zsh/` - ZSH configuration files
- `terminal/` - Terminal and iTerm2 preferences
- `oh-my-zsh/` - Custom themes and plugins
- `backup-metadata.txt` - Info about the backup source

### Specialized Guides

- **[GenAI/localLLM.md](./GenAI/localLLM.md)** - Complete guide to Ollama, Open WebUI, and local LLM models
- **[Python_Setup/setup.md](./Python_Setup/setup.md)** - Python virtual environments and package management

---

## 🔧 Manual Customization (After Installation)

After running the automated scripts, you may want to customize:

### Dock Customization

Edit `Scripts/update_dock.sh` to change which apps appear in your Dock.

### Terminal Theme

Change ZSH theme in `~/.zshrc`:
```bash
# Current theme: half-life
ZSH_THEME="half-life"

# Change to another theme (e.g., "robbyrussell")
ZSH_THEME="robbyrussell"
source ~/.zshrc
```

### System Preferences (Tahoe Features)

- **Menu Bar**: System Settings > Control Center - Customize what appears in menu bar
- **Dock**: System Settings > Dock & Menu Bar
- **Finder**: System Settings > Finder
- **App Icons**: Right-click app > Options > Tint (Light/Dark/Clear)

### Folder Colors & Emoji

Right-click any folder > Customize Tags to add colors and emoji to organize your files.

---

## 🆘 Troubleshooting

### Phase 1 Issues

**Problem:** Homebrew installation fails
```bash
# Try manual installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Problem:** GitHub CLI authentication fails
```bash
# Manually authenticate
gh auth login
```

### Phase 2 Issues

**Problem:** Terminal theme not applied
```bash
# Reload ZSH
exec zsh
# Or
source ~/.zshrc
```

**Problem:** Finder changes didn't apply
```bash
# Restart Finder
killall Finder
```

### Phase 3 Issues

**Problem:** Docker won't start
- Open Docker.app from Applications
- Wait for it to fully initialize
- Then try again

**Problem:** Ollama won't download models
- Check internet connection
- Ensure Docker is running
- Try manual: `ollama pull llama2`

### General Issues

Check the `POST-INSTALL-STEPS.md` for verification commands to test each phase.

---

## 📦 What's in This Repository

```
Mac-Setting/
├── README.md (this file)
├── PRE-INSTALLATION.md
├── POST-INSTALL-STEPS.md
├── DEVELOPMENT-SETUP.md
├── Scripts/
│   ├── phase-1-bootstrap.sh
│   ├── phase-2-basic-settings.sh
│   ├── phase-3-development.sh
│   ├── 1Password_GH_setup.sh
│   ├── terminal_settings.sh
│   ├── setup_finder.sh
│   ├── setup_ohmyzsh.sh
│   ├── update_dock.sh
│   └── prducttivity_tools_install.sh
├── Configs/
│   ├── zsh/ (backed-up configs)
│   ├── terminal/
│   ├── oh-my-zsh/
│   └── backup-metadata.txt
├── GenAI/
│   └── localLLM.md
├── Python_Setup/
│   └── setup.md
└── ARCHIVE/ (old documentation)
```

---

## 🔒 Security & Privacy

### Sensitive Information
- **Do NOT commit** `.env` files, API keys, or credentials
- **Use 1Password** for storing sensitive data (configured during Phase 1)
- **Use 1Password CLI** to securely access credentials from scripts

### Git Configuration
After Phase 1, Git is configured with:
- **User:** Nir Sheep
- **Email:** sheep.nir@gmail.com

Update these if needed:
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

---

## 🆙 Updating This Repository

To get the latest configurations and scripts:

```bash
cd ~/Developer/Mac-Setting
git pull origin main
```

---

## 📝 System Requirements

- **macOS Version:** Tahoe (26.0) or later
- **Architecture:** Apple Silicon (M1, M2, M3, M4, etc.)
- **RAM:** 8GB minimum (16GB+ recommended for development)
- **Disk Space:** 50GB+ free space
- **Internet:** Required for downloads (10+ GB total)

---

## 💡 Tips & Best Practices

### Backup Before Making Changes
```bash
# Create a Time Machine backup before major changes
# System Settings > General > Time Machine
```

### Keep Your Config Repo Updated
After customizing your setup, commit changes:
```bash
cd ~/Developer/Mac-Setting
git add .
git commit -m "Updated settings"
git push
```

### Virtual Environments for Projects
Always use virtual environments for Python projects:
```bash
python3 -m venv myproject
source myproject/bin/activate
pip install -r requirements.txt
```

### Docker Image Management
Keep your Docker system clean:
```bash
# Remove unused images
docker image prune -a

# Remove unused volumes
docker volume prune
```

---

## 🤝 Contributing

Found an issue or want to improve something? Great!

1. Create a new branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Test thoroughly
4. Commit with clear message: `git commit -m "Add your feature"`
5. Push: `git push origin feature/your-feature`
6. Open a pull request

---

## 📄 License

These scripts and configurations are provided as-is for personal Mac setup automation.

---

## ✅ Support & Issues

- Check `POST-INSTALL-STEPS.md` for verification steps
- Check `DEVELOPMENT-SETUP.md` for tool-specific help
- Review archived documentation in `ARCHIVE/` for additional context
- Check individual script comments for detailed information

---

## 🎯 What's Next After Installation?

After running all 3 phases, your Mac is ready for:

- ✅ Web development (Docker, containers, databases)
- ✅ Python development (data science, ML, AI)
- ✅ Local AI/LLM experimentation (Ollama)
- ✅ General development work
- ✅ Content creation (VS Code, etc.)

**Future additions:**
- Phase 4: Parallels Desktop & Windows gaming setup
- Additional language runtimes (Node.js, Rust, Go)
- Database setup (PostgreSQL, MongoDB)
- Container orchestration (Kubernetes basics)

---

**Version:** macOS Tahoe (26.x)
**Last Updated:** November 2025
**Target Systems:** Apple Silicon Macs (M1+)

Happy coding! 🚀
