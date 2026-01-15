# Work MacBook Setup Guide

## Phase 1: Initial Bootstrap Setup

### 1. Install Xcode Command Line Tools
```bash
xcode-select --install
```
Wait for the installation to complete, then verify:
```bash
xcode-select -p
```

### 2. Create Developer Folder and Clone Repository
```bash
mkdir -p ~/Developer
cd ~/Developer
git clone https://github.com/sheepnir/Mac-Setting.git
cd Mac-Setting
```

### 3. Install Homebrew Package Manager
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to PATH (Apple Silicon):
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Verify installation:
```bash
brew --version
```

### 4. Install Essential Development Tools via Homebrew
```bash
brew install git curl wget
```

Verify installations:
```bash
git --version
curl --version
wget --version
```

### 5. Configure Git Globally
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

Verify configuration:
```bash
git config --list --global
```

### 6. Set Up 1Password
```bash
brew install --cask 1password
brew install 1password-cli
```

Launch 1Password from Applications:
- Sign in with your account credentials
- Complete the authentication setup

Verify installation:
```bash
op --version
```

### 7. Restart Terminal
Close and reopen your terminal, or run:
```bash
exec zsh
```

---

## Phase 2: Productivity Tools & Development Environment

### 1. Install Productivity Applications
**Raycast (spotlight and automation):**
```bash
brew install --cask raycast
```

**Brave Browser:**
```bash
brew install --cask brave-browser
```

**Claude Desktop:**
```bash
brew install --cask claude
```

**ChatGPT Desktop:**
```bash
brew install --cask chatgpt
```

**Whisper Flow (transcription):**
```bash
brew install --cask whisper-flow
```

**Obsidian (note-taking):**
```bash
brew install --cask obsidian
```

### 2. Install Claude Code (CLI)
```bash
npm install -g @anthropic-ai/claude-code
```

Verify installation:
```bash
claude-code --version
```

### 3. Install Visual Studio Code
```bash
brew install --cask visual-studio-code
```

Verify installation:
```bash
code --version
```

**Set Up VS Code Extensions:**

Install essential extensions via CLI:
```bash
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension ms-python.python
code --install-extension eamodio.gitlens
code --install-extension ms-azuretools.vscode-docker
code --install-extension GitHub.Copilot
```

Or open VS Code and install manually:
- ESLint
- Prettier
- Python
- GitLens
- Docker
- GitHub Copilot
- Thunder Client or REST Client

### 4. Install Node.js and npm
```bash
brew install node
```

Verify installation:
```bash
node --version
npm --version
```

Install Yarn (optional):
```bash
npm install -g yarn
yarn --version
```

### 5. Install Python
```bash
brew install python
```

Verify installation:
```bash
python3 --version
pip3 --version
```

Create a virtual environment for projects (optional but recommended):
```bash
python3 -m venv ~/Developer/.venv
source ~/Developer/.venv/bin/activate
```

### 6. Install Ruby
```bash
brew install ruby
```

Add Ruby to PATH:
```bash
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zprofile
export PATH="/usr/local/opt/ruby/bin:$PATH"
```

Verify installation:
```bash
ruby --version
```

### 7. Set Up SSH Keys for GitHub
Generate SSH key:
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

Start SSH agent:
```bash
eval "$(ssh-agent -s)"
```

Add private key to SSH agent:
```bash
ssh-add ~/.ssh/id_ed25519
```

Display public key and copy it:
```bash
cat ~/.ssh/id_ed25519.pub
```

Add the SSH key to your GitHub account:
1. Go to [GitHub SSH Keys Settings](https://github.com/settings/keys)
2. Click "New SSH key"
3. Paste the key and save

Verify SSH connection:
```bash
ssh -T git@github.com
```

### 8. Install Git Tools
**GitHub CLI:**
```bash
brew install gh
gh auth login
```

**git-flow (optional):**
```bash
brew install git-flow
```

### 9. Install Database Tools
**PostgreSQL:**
```bash
brew install postgresql@15
brew services start postgresql@15
```

Verify installation:
```bash
psql --version
```

**MongoDB:**
```bash
brew install mongodb-community
brew services start mongodb-community
```

Verify installation:
```bash
mongosh --version
```

### 10. Install Docker
```bash
brew install --cask docker
```

Verify installation:
```bash
docker --version
```

### 11. Install Development Tools
**Postman (API testing):**
```bash
brew install --cask postman
```

**DBeaver (Database GUI):**
```bash
brew install --cask dbeaver-community
```

**Insomnia (REST/GraphQL client):**
```bash
brew install --cask insomnia
```

**JetBrains Toolbox (for IntelliJ, PyCharm, etc.):**
```bash
brew install jetbrains-toolbox
```

### 12. Verify Development Environment
```bash
node --version
npm --version
python3 --version
ruby --version
git --version
docker --version
code --version
```

---

## Phase 3: Advanced Tools and Optimization

### 1. Install Oh My Zsh (if not already installed)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2. Install Zsh Plugins
**Install Powerlevel10k theme:**
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Edit `~/.zshrc` and set:
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

**Install useful plugins:**
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Edit `~/.zshrc` and update plugins:
```bash
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
```

### 3. Configure Shell Aliases and Functions
Edit `~/.zshrc` and add custom aliases:
```bash
# Navigation
alias dev="cd ~/Developer"
alias projects="cd ~/Developer/projects"

# Development
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline"

# Quick shortcuts
alias ll="ls -lah"
alias cls="clear"
alias reload="source ~/.zshrc"

# Node/npm shortcuts
alias nr="npm run"
alias ni="npm install"

# Python
alias python="python3"
alias pip="pip3"

# Docker
alias dk="docker"
alias dkps="docker ps"
alias dklog="docker logs"
```

Reload shell:
```bash
source ~/.zshrc
```

### 4. Install Code Linters and Formatters
**ESLint and Prettier for JavaScript:**
```bash
npm install -g eslint prettier
```

**Black for Python:**
```bash
pip3 install black flake8
```

**Rubocop for Ruby:**
```bash
gem install rubocop
```

### 5. Install Pre-commit Hooks
```bash
brew install pre-commit
```

Create a `.pre-commit-config.yaml` in your project root (example):
```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.1.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files

  - repo: https://github.com/psf/black
    rev: 22.3.0
    hooks:
      - id: black
```

Install the hook:
```bash
pre-commit install
```

### 6. Install Development Tools
**Postman (API testing):**
```bash
brew install --cask postman
```

**DBeaver (Database GUI):**
```bash
brew install --cask dbeaver-community
```

**Insomnia (REST/GraphQL client):**
```bash
brew install --cask insomnia
```

**Terminal multiplexer - Tmux:**
```bash
brew install tmux
```

### 7. Install System Optimization Tools
**htop (system monitoring):**
```bash
brew install htop
```

**Bottom (system monitor):**
```bash
brew install bottom
```

**Disk usage analyzer:**
```bash
brew install ncdu
```

### 8. Install Additional System Tools
**Karabiner (keyboard customization):**
```bash
brew install --cask karabiner-elements
```

**Alfred (alternative to Raycast, optional):**
```bash
brew install --cask alfred
```

### 9. Configure macOS Settings for Development
**Show hidden files in Finder:**
```bash
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder
```

**Enable key repeat in terminal apps:**
```bash
defaults write -g ApplePressAndHoldEnabled -bool false
```

**Speed up keyboard repeat:**
```bash
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
```

### 10. Set Up Git Advanced Features
**Configure Git aliases:**
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual 'log --graph --oneline --all'
```

**Set up commit signing (optional):**
```bash
git config --global user.signingkey YOUR_GPG_KEY_ID
git config --global commit.gpgsign true
```

### 11. Create Development Workspace Structure
```bash
mkdir -p ~/Developer/projects
mkdir -p ~/Developer/learning
mkdir -p ~/Developer/work
```

### 12. Final System Update and Cleanup
```bash
brew update
brew upgrade
brew cleanup
brew doctor
```

### 13. Create System Backup
**Enable Time Machine:**
1. Go to System Settings → General → Time Machine
2. Click "Add Backup Disk"
3. Select your backup drive

**Or set up iCloud sync:**
1. Go to System Settings → [Your Name] → iCloud
2. Enable desired options (Documents, Desktop, Mail, etc.)

### 14. Verify Complete Setup
```bash
echo "=== System Info ==="
sw_vers
echo "\n=== Development Tools ==="
node --version && npm --version
python3 --version
ruby --version
git --version
docker --version
echo "\n=== Command Verification ==="
which code
which docker
which gh
echo "\n=== All set! ==="
```

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
