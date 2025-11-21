#!/bin/bash

################################################################################
# Phase 1: Bootstrap Installation Script
# Purpose: Install essential tools (Homebrew, 1Password, GitHub CLI, clone repo)
# macOS Tahoe (26.x) compatible
# Duration: ~10-15 minutes
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}==== $1 ====${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

################################################################################
# Phase 1 Start
################################################################################

clear
echo -e "${BLUE}"
cat << "EOF"
╔════════════════════════════════════════════════════════════════════════════╗
║                   PHASE 1: BOOTSTRAP INSTALLATION                         ║
║                        macOS Tahoe Setup                                   ║
║                                                                            ║
║  Installing: Homebrew, 1Password, Git, GitHub CLI, cloning Mac-Setting    ║
║  Estimated time: 10-15 minutes                                            ║
╚════════════════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Check system
print_header "System Check"
OS_VERSION=$(sw_vers -productVersion)
SYSTEM_MODEL=$(system_profiler SPHardwareDataType 2>/dev/null | grep "Model Identifier" | awk '{print $3}' || echo "Unknown")
echo "macOS Version: $OS_VERSION"
echo "System Model: $SYSTEM_MODEL"

################################################################################
# 1. Install Homebrew
################################################################################

print_header "Step 1/4: Installing Homebrew"

if command -v brew &> /dev/null; then
    print_success "Homebrew is already installed"
    brew --version
else
    print_warning "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [ -d "/opt/homebrew/bin" ]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        print_success "Homebrew installed and added to PATH"
    fi
fi

# Verify Homebrew
brew --version

################################################################################
# 2. Install 1Password
################################################################################

print_header "Step 2/4: Installing 1Password"

if [ -d "/Applications/1Password.app" ] || [ -d "/Applications/1Password 7.app" ] || [ -d "/Applications/1Password 8.app" ]; then
    print_success "1Password app is already installed"
else
    print_warning "Installing 1Password app..."
    brew install --cask 1password
    print_success "1Password app installed"
fi

# Install 1Password CLI
if command -v op &> /dev/null; then
    print_success "1Password CLI is already installed"
    op --version
else
    print_warning "Installing 1Password CLI..."
    brew install 1password-cli
    print_success "1Password CLI installed"
fi

################################################################################
# 3. Install Git & GitHub CLI
################################################################################

print_header "Step 3/4: Installing Git & GitHub CLI"

# Install Git
if command -v git &> /dev/null; then
    print_success "Git is already installed"
    git --version
else
    print_warning "Installing Git..."
    brew install git
    print_success "Git installed"
fi

# Configure Git (if not already configured)
GIT_USER=$(git config --global user.name 2>/dev/null || echo "")
GIT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

if [ -z "$GIT_USER" ]; then
    print_warning "Configuring Git with default values..."
    git config --global user.name "Nir Sheep"
    git config --global user.email "sheep.nir@gmail.com"
    print_success "Git configured"
else
    print_success "Git is already configured"
    echo "User: $GIT_USER"
    echo "Email: $GIT_EMAIL"
fi

# Install GitHub CLI
if command -v gh &> /dev/null; then
    print_success "GitHub CLI is already installed"
    gh --version
else
    print_warning "Installing GitHub CLI..."
    brew install gh
    print_success "GitHub CLI installed"
fi

################################################################################
# 4. Clone Mac-Setting Repository
################################################################################

print_header "Step 4/4: Cloning Mac-Setting Repository"

REPO_DIR="$HOME/Developer/Mac-Setting"

if [ -d "$REPO_DIR" ]; then
    print_warning "Mac-Setting repository already exists at $REPO_DIR"
    cd "$REPO_DIR"
    print_warning "Updating repository..."
    git pull origin main
    print_success "Repository updated"
else
    print_warning "Cloning Mac-Setting repository..."
    mkdir -p "$HOME/Developer"
    cd "$HOME/Developer"
    git clone https://github.com/sheepnir/Mac-Setting.git
    print_success "Repository cloned to $REPO_DIR"
fi

################################################################################
# Phase 1 Complete
################################################################################

print_header "PHASE 1 COMPLETE ✓"

echo -e "${GREEN}All bootstrap tools installed successfully!${NC}\n"
echo "Installed components:"
echo "  ✓ Homebrew (package manager)"
echo "  ✓ 1Password (app + CLI)"
echo "  ✓ Git (version control)"
echo "  ✓ GitHub CLI (gh command)"
echo "  ✓ Mac-Setting repository"
echo ""
echo "Next steps:"
echo ""
echo "1. If using 1Password for the first time:"
echo "   - Open 1Password app from Applications"
echo "   - Sign in with your 1Password account"
echo "   - Authenticate the CLI: eval \$(op signin)"
echo ""
echo "2. If using GitHub CLI for the first time:"
echo "   - Authenticate: gh auth login"
echo "   - Follow the prompts"
echo ""
echo "3. When ready, run PHASE 2:"
echo ""
echo -e "   ${BLUE}${REPO_DIR}/Scripts/phase-2-basic-settings.sh${NC}"
echo ""
echo "Or if you're in the Mac-Setting directory:"
echo ""
echo -e "   ${BLUE}./Scripts/phase-2-basic-settings.sh${NC}"
echo ""
echo -e "${GREEN}Happy setting up! 🚀${NC}\n"
