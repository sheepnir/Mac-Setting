# Work MacBook Setup Guide

## Phase 1: Initial Bootstrap Setup

### 1. Install Xcode Command Line Tools
```bash
xcode-select --install
```

### 2. Clone the Repository
```bash
git clone <repository-url>
cd Mac-Setting
```

### 3. Run Phase 1 Bootstrap Script
```bash
bash phase-1-bootstrap.sh
```

**What Phase 1 Includes:**
- Xcode Command Line Tools installation
- Homebrew package manager installation
- Essential development tools (git, curl, wget)
- System configuration updates
- Shell environment setup

### 4. Set Up 1Password
- Launch 1Password from Applications
- Sign in with your account credentials
- Complete the authentication setup
- Configure browser extension

### 5. Restart Terminal
```bash
exec zsh
```

---

## Phase 2: Development Environment Setup

### 1. Run Phase 2 Installation Script
```bash
bash phase-2-installation.sh
```

**What Phase 2 Includes:**
- Programming language installations (Node.js, Python, Ruby, etc.)
- Package managers (npm, Yarn, pip)
- Development tools and IDEs
  - Visual Studio Code
  - Cursor (IDE)
  - JetBrains toolchain
- Git configuration and SSH key setup
- Database tools (PostgreSQL, MongoDB)
- Docker and container tools
- Productivity applications
  - Slack
  - Discord
  - Notion
  - Figma

### 2. Configure Git
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 3. Set Up SSH Keys for GitHub
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub
```
- Copy the output and add it to GitHub SSH keys

### 4. Test Development Environment
```bash
node --version
python --version
ruby --version
```

---

## Phase 3: Advanced Tools and Optimization

### 1. Run Phase 3 Configuration Script
```bash
bash phase-3-config.sh
```

**What Phase 3 Includes:**
- Advanced terminal customization
  - Oh My Zsh configuration
  - Custom themes and plugins
  - Shell aliases and functions
- Development environment optimization
  - Performance tuning
  - Memory optimization
  - Battery optimization settings
- Advanced Git workflows
  - Commit hooks setup
  - Pre-commit configuration
- Developer tools
  - Code linters and formatters
  - Testing frameworks
  - Build tools configuration
- System monitoring and maintenance
  - Log management
  - Disk space optimization
  - Backup configuration

### 2. Customize Your Shell (Optional)
Edit `~/.zshrc` to add custom aliases and functions:
```bash
nano ~/.zshrc
```

### 3. Install Additional Productivity Tools (Optional)
- Raycast or Alfred for enhanced spotlight
- Bartender for menu bar management
- BetterTouchTool for system automation

### 4. Set Up Development Workspace
- Create your standard project directories
- Clone frequently used repositories
- Configure your IDE preferences

### 5. Final System Update
```bash
brew update && brew upgrade
```

### 6. Create a System Backup
- Time Machine backup configuration
- Cloud storage sync setup (iCloud, Dropbox, etc.)

---

## Post-Installation Checklist

- [ ] Phase 1 bootstrap completed
- [ ] 1Password authenticated and configured
- [ ] Git configured with your credentials
- [ ] SSH keys generated and added to GitHub
- [ ] Phase 2 development tools installed
- [ ] Programming languages verified
- [ ] Phase 3 advanced tools installed
- [ ] Shell customization completed
- [ ] System backup configured
- [ ] All development tools tested

---

## Troubleshooting

### Command Not Found After Installation
```bash
source ~/.zshrc
```

### Git SSH Authentication Issues
Verify your SSH key is properly added:
```bash
ssh -T git@github.com
```

### Homebrew Permission Issues
```bash
sudo chown -R $(whoami) /usr/local/Cellar
```

### Clean Up Installation (if needed)
```bash
brew cleanup
brew doctor
```

---

## Additional Resources

- [Homebrew Documentation](https://brew.sh)
- [GitHub SSH Setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [1Password Support](https://support.1password.com)
- [VSCode Configuration](https://code.visualstudio.com/docs/setup/setup-overview)
