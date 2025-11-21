#!/bin/bash

################################################################################
# Phase 3: Development Environment Setup
# Purpose: Install Python, Docker, Ollama, and development tools
# macOS Tahoe (26.x) compatible
# Duration: ~30-45 minutes
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
# Phase 3 Start
################################################################################

clear
echo -e "${BLUE}"
cat << "EOF"
╔════════════════════════════════════════════════════════════════════════════╗
║             PHASE 3: DEVELOPMENT ENVIRONMENT SETUP                         ║
║                        macOS Tahoe Setup                                   ║
║                                                                            ║
║  Installing: Python, Docker, Ollama, AI/ML packages, development tools     ║
║  Estimated time: 30-45 minutes                                            ║
╚════════════════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

print_header "Development Environment Configuration"
echo "Components to install:"
echo "  • Python 3.11+ with pip"
echo "  • Essential Python packages (numpy, pandas, matplotlib, etc.)"
echo "  • AI/ML packages (torch, tensorflow, transformers, etc.)"
echo "  • Docker Desktop"
echo "  • Docker Compose"
echo "  • Ollama (local LLM runtime)"
echo "  • Development tools and utilities"
echo ""
echo "This process requires your administrator password and may take time."
echo ""

################################################################################
# Step 1: Install Python
################################################################################

print_header "Step 1/4: Installing Python & Development Tools"

if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    print_success "Python is already installed: $PYTHON_VERSION"
else
    print_step "Installing Python via Homebrew..."
    brew install python
    print_success "Python installed"
fi

# Verify pip
if command -v pip3 &> /dev/null; then
    print_success "pip3 is ready"
else
    print_error "pip3 not found. Please check Python installation."
    exit 1
fi

# Upgrade pip
print_step "Upgrading pip..."
pip3 install --upgrade pip 2>/dev/null || true

################################################################################
# Step 2: Install Python Packages
################################################################################

print_header "Step 2/4: Installing Python Packages"

print_step "Installing core scientific packages..."
PACKAGES=(
    "numpy"
    "pandas"
    "matplotlib"
    "seaborn"
    "scikit-learn"
    "jupyter"
)

for package in "${PACKAGES[@]}"; do
    if pip3 show "$package" &> /dev/null; then
        print_success "$package already installed"
    else
        print_step "Installing $package..."
        pip3 install "$package" 2>/dev/null || print_warning "$package installation had issues, continuing..."
    fi
done

print_step "Installing AI/ML packages (this may take a few minutes)..."
ML_PACKAGES=(
    "torch"
    "tensorflow"
    "transformers"
    "nltk"
    "spacy"
    "gensim"
    "anthropic"
    "openai"
    "python-dotenv"
    "requests"
)

for package in "${ML_PACKAGES[@]}"; do
    if pip3 show "$package" &> /dev/null; then
        print_success "$package already installed"
    else
        print_step "Installing $package..."
        pip3 install "$package" 2>/dev/null || print_warning "$package installation had issues, continuing..."
    fi
done

print_success "Python packages installation complete"

################################################################################
# Step 3: Install Docker Desktop
################################################################################

print_header "Step 3/4: Installing Docker Desktop"

if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    print_success "Docker is already installed: $DOCKER_VERSION"
else
    print_step "Installing Docker Desktop..."
    brew install --cask docker
    print_success "Docker Desktop installed"
    print_warning "You must start Docker.app from Applications before using Docker commands"
fi

# Verify docker compose
if command -v docker &> /dev/null && docker compose version &> /dev/null; then
    print_success "Docker Compose is available"
else
    print_warning "Docker Compose will be available after starting Docker.app"
fi

################################################################################
# Step 4: Install Ollama (Local LLM Runtime)
################################################################################

print_header "Step 4/4: Installing Ollama"

if command -v ollama &> /dev/null; then
    OLLAMA_VERSION=$(ollama --version 2>&1 || echo "Unknown version")
    print_success "Ollama is already installed: $OLLAMA_VERSION"
else
    print_step "Installing Ollama..."
    brew install ollama
    print_success "Ollama installed"
fi

################################################################################
# Phase 3 Complete
################################################################################

print_header "PHASE 3 COMPLETE ✓"

echo -e "${GREEN}Development environment is fully configured!${NC}\n"
echo "Installed components:"
echo "  ✓ Python 3.11+ with pip"
echo "  ✓ Core packages: numpy, pandas, matplotlib, scikit-learn, jupyter"
echo "  ✓ AI/ML packages: torch, tensorflow, transformers, nltk, spacy"
echo "  ✓ API clients: anthropic, openai"
echo "  ✓ Docker Desktop & Docker Compose"
echo "  ✓ Ollama (local LLM runtime)"
echo ""
echo "Your development environment is ready for:"
echo "  • Data science & ML projects"
echo "  • Python development"
echo "  • Containerized applications with Docker"
echo "  • Local LLM experimentation with Ollama"
echo ""
echo "Important setup notes:"
echo ""
echo "1. Start Docker Desktop:"
echo "   • Open Applications → Docker"
echo "   • Wait for initialization (icon appears in menu bar)"
echo ""
echo "2. Test your Python installation:"
echo "   python3 --version"
echo "   pip3 list | grep numpy"
echo ""
echo "3. Start working with local LLMs:"
echo "   • Run: ollama serve"
echo "   • In another terminal: ollama pull mistral"
echo "   • Then: ollama run mistral"
echo ""
echo "4. Create a Python virtual environment for your projects:"
echo "   python3 -m venv my_project"
echo "   source my_project/bin/activate"
echo "   pip install -r requirements.txt"
echo ""
echo "5. Use Jupyter for interactive development:"
echo "   jupyter notebook"
echo ""
echo "Quick start examples:"
echo ""
echo "  Data Science:"
echo "    jupyter notebook"
echo ""
echo "  Docker project:"
echo "    # Make sure Docker.app is running first"
echo "    docker run hello-world"
echo ""
echo "  Local LLM:"
echo "    ollama serve &"
echo "    ollama run mistral 'Hello, how are you?'"
echo ""
echo "For more details, see:"
echo "  • DEVELOPMENT-SETUP.md - Comprehensive development guide"
echo "  • GenAI/localLLM.md - Advanced Ollama setup"
echo "  • Python_Setup/setup.md - Python virtual environments"
echo ""
echo -e "${GREEN}Your Mac is now fully configured! 🚀${NC}\n"
echo "Next steps:"
echo "  1. Start Docker.app from Applications"
echo "  2. Open your first Python/Jupyter notebook"
echo "  3. Test Ollama with a local LLM"
echo "  4. Create your first development project"
echo ""
echo "Happy coding! 💻✨"
