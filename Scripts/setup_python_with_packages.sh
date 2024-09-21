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

# Create a virtual environment
VENV_PATH="$HOME/python_env"
echo "Creating virtual environment at $VENV_PATH..."
$BREW_PYTHON_PATH -m venv $VENV_PATH

# Activate the virtual environment
source $VENV_PATH/bin/activate

# Upgrade pip in the virtual environment
pip install --upgrade pip

# Install packages in the virtual environment
echo "Installing common Python packages and API libraries..."
pip install \
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

# Add aliases and activation to .zshrc
echo "Adding aliases and activation to .zshrc..."
echo "alias python='$VENV_PATH/bin/python'" >> ~/.zshrc
echo "alias pip='$VENV_PATH/bin/pip'" >> ~/.zshrc
echo "source $VENV_PATH/bin/activate" >> ~/.zshrc

# Set up VS Code to use the virtual environment
echo "Configuring VS Code..."
mkdir -p ~/.vscode
cat << EOF > ~/.vscode/settings.json
{
    "python.defaultInterpreterPath": "$VENV_PATH/bin/python",
    "python.terminal.activateEnvironment": true
}
EOF

echo "Setup complete! Please restart your terminal and VS Code for changes to take effect."
echo "After restarting, your terminal will automatically activate the virtual environment."
echo "Run 'which python' to verify it points to: $VENV_PATH/bin/python"