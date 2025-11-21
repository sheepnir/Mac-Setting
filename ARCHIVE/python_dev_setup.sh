#!/bin/bash

# Install Miniconda
brew install --cask miniconda

# Initialize conda for zsh
conda init zsh

# Get the latest stable Python version
PYTHON_VERSION=$(conda search python | grep -v 'pkgs' | awk '{print $2}' | sort -V | tail -n 1)

# Create a new conda environment for the test project with the latest Python version
conda create -n testproject python=$PYTHON_VERSION -y

# Activate the new environment
conda activate testproject

# Add conda-forge to the channels
conda config --add channels conda-forge

# Install essential data science packages
conda install -y numpy pandas matplotlib seaborn scikit-learn jupyter

# Try to install openai and anthropic using conda-forge
if conda install -y openai anthropic; then
    echo "openai and anthropic packages installed successfully using conda"
else
    echo "Unable to install openai and anthropic using conda. Falling back to pip."
    pip install openai anthropic
fi

# Install VSCode Python extension
code --install-extension ms-python.python

# Install VSCode Jupyter extension
code --install-extension ms-toolsai.jupyter

echo "Python development environment has been set up successfully!"
echo "Python version installed: $PYTHON_VERSION"
echo "To activate your test project environment, run: conda activate testproject"