#!/bin/bash

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install Python using Homebrew
echo "Installing Python..."
brew install python

# Get the path of the Homebrew-installed Python
BREW_PYTHON_PATH=$(brew --prefix python)/bin/python3
BREW_PIP_PATH=$(brew --prefix python)/bin/pip3

# Verify the paths
echo "Homebrew Python path: $BREW_PYTHON_PATH"
echo "Homebrew Pip path: $BREW_PIP_PATH"

# Add aliases to .zshrc (assuming you're using zsh, which is default on newer macOS)
echo "Adding aliases to .zshrc..."
echo "alias python='$BREW_PYTHON_PATH'" >> ~/.zshrc
echo "alias pip='$BREW_PIP_PATH'" >> ~/.zshrc

# Set up VS Code to use the Homebrew-installed Python
echo "Configuring VS Code..."
mkdir -p ~/.vscode
cat << EOF > ~/.vscode/settings.json
{
    "python.defaultInterpreterPath": "$BREW_PYTHON_PATH",
    "python.terminal.activateEnvironment": true,
    "python.pythonPath": "$BREW_PYTHON_PATH"
}
EOF

# Install common packages and API libraries
echo "Installing common Python packages and API libraries..."
$BREW_PIP_PATH install --upgrade pip
$BREW_PIP_PATH install \
    requests \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    jupyter \
    anthropic \
    openai \
    python-dotenv

echo "Setup complete! Please restart your terminal and VS Code for changes to take effect."
echo "After restarting, run 'which python' to verify it points to: $BREW_PYTHON_PATH"
echo "Common packages and API libraries have been installed."