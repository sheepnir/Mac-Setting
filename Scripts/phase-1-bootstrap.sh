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
# Pre-Flight Check
################################################################################

print_header "Pre-Flight Check: What You'll Need"

echo "This script will install and configure:"
echo "  ✓ Homebrew (macOS package manager)"
echo "  ✓ 1Password (app + CLI)"
echo "  ✓ Git & GitHub CLI"
echo "  ✓ Mac-Setting repository"
echo ""
echo "Important: You will be prompted to:"
echo "  • Open 1Password and sign in with your credentials"
echo "  • Run 'gh auth login' to authenticate with GitHub"
echo ""
echo "Have ready:"
echo "  ✓ 1Password account email & master password"
echo "  ✓ GitHub account login (username & password/2FA)"
echo "  ✓ Stable internet connection"
echo ""
read -p "Press Enter to continue or Ctrl+C to cancel..."

################################################################################
# 1. Install Homebrew
################################################################################

print_header "Step 1/6: Installing Homebrew"

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

print_header "Step 2/6: Installing 1Password"

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

# Prompt user to sign in to 1Password
print_warning "Next: Open 1Password and sign in"
echo ""
echo "1Password app will now open. Please:"
echo "  1. Click 'Sign in' in the 1Password window"
echo "  2. Enter your 1Password account email"
echo "  3. Enter your 1Password master password"
echo "  4. Complete any 2FA authentication if prompted"
echo "  5. Keep 1Password running in the background"
echo ""
read -p "Press Enter after you've signed into 1Password..."

# Open 1Password
open -a "1Password 7" 2>/dev/null || open -a "1Password 8" 2>/dev/null || open -a "1Password" 2>/dev/null

# Give user time to sign in
sleep 5

# Verify 1Password is running
if pgrep "1Password" > /dev/null; then
    print_success "1Password is running"
else
    print_warning "1Password may not be running. Please open it from Applications."
fi

################################################################################
# 3. Install Git & GitHub CLI
################################################################################

print_header "Step 3/6: Installing Git & GitHub CLI"

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
# 4. Authenticate with GitHub
################################################################################

print_header "Step 4/6: Authenticate with GitHub"

# Check if already authenticated
if gh auth status &> /dev/null; then
    print_success "GitHub CLI is already authenticated"
    gh auth status
else
    print_warning "GitHub authentication required"
    echo ""
    echo "You will be prompted to authenticate with GitHub."
    echo "Follow these steps:"
    echo "  1. When asked for protocol, choose: HTTPS"
    echo "  2. When asked to authenticate Git, choose: Yes"
    echo "  3. When asked how to authenticate, choose: Login with a web browser"
    echo "  4. A browser window will open - authorize GitHub CLI"
    echo "  5. Return to this terminal"
    echo ""
    read -p "Press Enter to start GitHub authentication..."

    # Run GitHub auth login
    gh auth login

    # Verify authentication
    if gh auth status &> /dev/null; then
        print_success "GitHub CLI authenticated successfully"
        gh auth status
    else
        print_error "GitHub authentication failed. You can run 'gh auth login' manually later."
    fi
fi

################################################################################
# 5. Clone Mac-Setting Repository
################################################################################

print_header "Step 5/6: Cloning Mac-Setting Repository"

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

echo -e "${GREEN}All bootstrap tools installed and configured!${NC}\n"
echo "Completed steps:"
echo "  ✓ Step 1: Homebrew installed (package manager)"
echo "  ✓ Step 2: 1Password app & CLI installed"
echo "  ✓ Step 3: Git & GitHub CLI installed"
echo "  ✓ Step 4: GitHub CLI authenticated"
echo "  ✓ Step 5: Mac-Setting repository cloned"
echo ""
echo "What was set up:"
echo "  ✓ Homebrew - Package manager for macOS"
echo "  ✓ 1Password - Password manager (keep running in background)"
echo "  ✓ Git - Version control system"
echo "  ✓ GitHub CLI - Command-line GitHub access"
echo "  ✓ Repository - All setup scripts and guides"
echo ""
echo "Important notes:"
echo "  • Keep 1Password running in the background"
echo "  • You're authenticated with GitHub"
echo "  • Repository is cloned to ~/Developer/Mac-Setting"
echo ""
echo "Next: Run PHASE 2:"
echo ""
echo -e "   ${BLUE}${REPO_DIR}/Scripts/phase-2-basic-settings.sh${NC}"
echo ""
echo "Or if you're in the Mac-Setting directory:"
echo ""
echo -e "   ${BLUE}./Scripts/phase-2-basic-settings.sh${NC}"
echo ""
echo -e "${GREEN}Happy setting up! 🚀${NC}\n"
