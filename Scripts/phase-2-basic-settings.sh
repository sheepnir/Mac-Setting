#!/bin/bash

################################################################################
# Phase 2: Basic Settings & Essential Tools
# Purpose: Run all basic setup scripts in correct order
# macOS Tahoe (26.x) compatible
# Duration: ~20-30 minutes
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

print_step() {
    echo -e "${BLUE}→ $1${NC}"
}

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

################################################################################
# Phase 2 Start
################################################################################

clear
echo -e "${BLUE}"
cat << "EOF"
╔════════════════════════════════════════════════════════════════════════════╗
║              PHASE 2: BASIC SETTINGS & ESSENTIAL TOOLS                     ║
║                        macOS Tahoe Setup                                   ║
║                                                                            ║
║  Configuring: Terminal, Finder, Dock, Oh My Zsh, Productivity Tools        ║
║  Estimated time: 20-30 minutes                                            ║
╚════════════════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

print_header "Phase 2 Configuration"
echo "Scripts will be run in this order:"
echo "  1. Terminal & ZSH settings"
echo "  2. Finder preferences"
echo "  3. Oh My Zsh framework"
echo "  4. Dock customization"
echo "  5. Productivity tools installation"
echo ""
echo "This process will make several system changes and may prompt for password."
echo ""

################################################################################
# Verify scripts exist
################################################################################

print_header "Verifying scripts"

SCRIPTS=(
    "terminal_settings.sh"
    "setup_finder.sh"
    "setup_ohmyzsh.sh"
    "update_dock.sh"
    "prducttivity_tools_install.sh"
)

for script in "${SCRIPTS[@]}"; do
    if [ -f "$SCRIPT_DIR/$script" ]; then
        print_success "Found: $script"
    else
        print_error "Missing: $script"
        echo "Expected location: $SCRIPT_DIR/$script"
        exit 1
    fi
done

################################################################################
# Step 1: Terminal & ZSH Settings
################################################################################

print_header "Step 1/5: Terminal & ZSH Settings"
print_step "Running: terminal_settings.sh"
echo "This will restore ZSH configs and Oh My Zsh custom themes/plugins"

if [ -f "$SCRIPT_DIR/terminal_settings.sh" ]; then
    chmod +x "$SCRIPT_DIR/terminal_settings.sh"
    bash "$SCRIPT_DIR/terminal_settings.sh" || print_warning "Some terminal settings may have failed, continuing..."
    print_success "Terminal settings applied"
else
    print_error "terminal_settings.sh not found"
    exit 1
fi

################################################################################
# Step 2: Finder Preferences
################################################################################

print_header "Step 2/5: Finder Preferences"
print_step "Running: setup_finder.sh"
echo "This will set list view, show hidden files, configure sidebar, etc."

if [ -f "$SCRIPT_DIR/setup_finder.sh" ]; then
    chmod +x "$SCRIPT_DIR/setup_finder.sh"
    bash "$SCRIPT_DIR/setup_finder.sh"
    print_success "Finder preferences applied"
    print_warning "Finder will restart. Please wait..."
    sleep 2
else
    print_error "setup_finder.sh not found"
    exit 1
fi

################################################################################
# Step 3: Oh My Zsh Framework
################################################################################

print_header "Step 3/5: Oh My Zsh Framework"
print_step "Running: setup_ohmyzsh.sh"
echo "This will install Oh My Zsh with half-life theme and plugins"

if [ -f "$SCRIPT_DIR/setup_ohmyzsh.sh" ]; then
    chmod +x "$SCRIPT_DIR/setup_ohmyzsh.sh"
    bash "$SCRIPT_DIR/setup_ohmyzsh.sh" || print_warning "Some Oh My Zsh setup may have failed, continuing..."
    print_success "Oh My Zsh framework configured"
else
    print_error "setup_ohmyzsh.sh not found"
    exit 1
fi

################################################################################
# Step 4: Dock Customization
################################################################################

print_header "Step 4/5: Dock Customization"
print_step "Running: update_dock.sh"
echo "This will customize your Dock with essential apps and folders"

if [ -f "$SCRIPT_DIR/update_dock.sh" ]; then
    chmod +x "$SCRIPT_DIR/update_dock.sh"
    bash "$SCRIPT_DIR/update_dock.sh"
    print_success "Dock customized"
    print_warning "Dock will restart. Please wait..."
    sleep 2
else
    print_error "update_dock.sh not found"
    exit 1
fi

################################################################################
# Step 5: Productivity Tools
################################################################################

print_header "Step 5/5: Productivity Tools Installation"
print_step "Running: prducttivity_tools_install.sh"
echo "This will install browsers, editors, Slack, Raycast, and more"
echo "This step may take 10-15 minutes as it downloads and installs applications"

if [ -f "$SCRIPT_DIR/prducttivity_tools_install.sh" ]; then
    chmod +x "$SCRIPT_DIR/prducttivity_tools_install.sh"
    bash "$SCRIPT_DIR/prducttivity_tools_install.sh" || print_warning "Some applications may not have installed, continuing..."
    print_success "Productivity tools installed"
else
    print_error "prducttivity_tools_install.sh not found"
    exit 1
fi

################################################################################
# Phase 2 Complete
################################################################################

print_header "PHASE 2 COMPLETE ✓"

echo -e "${GREEN}Basic settings and essential tools are now installed!${NC}\n"
echo "Configuration applied:"
echo "  ✓ Terminal with ZSH and Oh My Zsh"
echo "  ✓ Finder in list view with custom sidebar"
echo "  ✓ Customized Dock with apps and folders"
echo "  ✓ Productivity tools (Chrome, VS Code, Slack, etc.)"
echo ""
echo "Your Mac now has:"
echo "  • Beautiful themed terminal (half-life theme)"
echo "  • Organized Finder with quick access folders"
echo "  • Clean Dock with essential applications"
echo "  • All productivity tools ready to use"
echo ""
echo "Recommended next steps:"
echo ""
echo "1. Reload ZSH (to see changes):"
echo "   exec zsh"
echo ""
echo "2. Check Finder and Dock (Apple menu → Dock & Menu Bar)"
echo ""
echo "3. Test terminal by opening a new Terminal window"
echo ""
echo "4. When ready, run PHASE 3 (Development Environment):"
echo ""
echo -e "   ${BLUE}${REPO_DIR}/Scripts/phase-3-development.sh${NC}"
echo ""
echo "Or:"
echo ""
echo -e "   ${BLUE}./Scripts/phase-3-development.sh${NC}"
echo ""
echo -e "${GREEN}You're halfway there! 🎉${NC}\n"
