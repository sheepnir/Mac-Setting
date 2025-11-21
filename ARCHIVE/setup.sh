#!/usr/bin/env bash
set -e

# 1. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Update Homebrew
echo "Updating Homebrew…"
brew update

# 3. Install latest Python
echo "Installing Python…"
brew install python

# 4. Upgrade pip and install virtualenv
echo "Configuring pip and virtualenv…"
pip3 install --upgrade pip
pip3 install virtualenv

# 5. Create & activate a global dev venv
VENV_DIR="$HOME/.venvs/python-dev"
mkdir -p "$(dirname "$VENV_DIR")"
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

# 6. Install core Python packages
echo "Installing Flask, OpenAI & Anthropic SDKs…"
pip install --upgrade flask openai anthropic

# 7. Install VSCode if missing
if ! command -v code &>/dev/null; then
    echo "Installing Visual Studio Code…"
    brew install --cask visual-studio-code
fi

# 8. Install common VSCode extensions
echo "Adding VSCode extensions…"
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension njpwerner.autodocstring
code --install-extension ms-toolsai.jupyter
code --install-extension ms-python.black-formatter
code --install-extension ms-python.isort

# 9. Add HTML/CSS support & beautify
code --install-extension ecmel.vscode-html-css
code --install-extension HookyQR.beautify

# 10. Install GitHub Copilot
code --install-extension GitHub.copilot

echo
echo "✅ Python & VSCode setup complete."
echo "Activate your env with:"
echo "  source $VENV_DIR/bin/activate"
