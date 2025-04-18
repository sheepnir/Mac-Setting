# MacBook - VS Code and GitHub Setup

This guide covers setting up Visual Studio Code with essential extensions and configuring GitHub for development on your MacBook Pro M3 Max.

## Step 1: Install VS Code

If you haven't already installed VS Code during the basic setup:

```bash
brew install --cask visual-studio-code
```

## Step 2: Install Essential VS Code Extensions

1. Create a script to install VS Code extensions:
   ```bash
   cd ~/Developer/setup-scripts
   nano install_vscode_extensions.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Install general development extensions
   code --install-extension ms-vscode.vscode-typescript-next
   code --install-extension streetsidesoftware.code-spell-checker
   code --install-extension eamodio.gitlens
   code --install-extension esbenp.prettier-vscode
   code --install-extension usernamehw.errorlens
   code --install-extension wayou.vscode-todo-highlight
   code --install-extension yzhang.markdown-all-in-one
   
   # Install Python extensions
   code --install-extension ms-python.python
   code --install-extension ms-python.vscode-pylance
   code --install-extension ms-python.black-formatter
   code --install-extension matangover.mypy
   code --install-extension ms-toolsai.jupyter
   
   # Install Docker extensions
   code --install-extension ms-azuretools.vscode-docker
   code --install-extension ms-vscode-remote.remote-containers
   
   # Install Git extensions
   code --install-extension mhutchie.git-graph
   code --install-extension donjayamanne.githistory
   
   # Install theme extensions (optional - adjust to your preference)
   code --install-extension github.github-vscode-theme
   code --install-extension zhuangtongfa.material-theme
   
   echo "VS Code extensions have been installed successfully!"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x install_vscode_extensions.sh
   ./install_vscode_extensions.sh
   ```

## Step 3: Configure VS Code Settings

1. Create a script to configure VS Code settings:
   ```bash
   cd ~/Developer/setup-scripts
   nano configure_vscode.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create VS Code settings directory if it doesn't exist
   mkdir -p ~/Library/Application\ Support/Code/User
   
   # Configure VS Code settings
   cat > ~/Library/Application\ Support/Code/User/settings.json << EOF
   {
     "editor.formatOnSave": true,
     "editor.formatOnPaste": true,
     "editor.minimap.enabled": false,
     "editor.rulers": [88],
     "editor.tabSize": 4,
     "editor.wordWrap": "on",
     "editor.linkedEditing": true,
     "editor.bracketPairColorization.enabled": true,
     "editor.guides.bracketPairs": true,
     "editor.suggestSelection": "first",
     "editor.cursorBlinking": "smooth",
     "editor.cursorSmoothCaretAnimation": "on",
     
     "files.trimTrailingWhitespace": true,
     "files.insertFinalNewline": true,
     "files.trimFinalNewlines": true,
     "files.autoSave": "onFocusChange",
     
     "workbench.startupEditor": "none",
     "workbench.colorTheme": "GitHub Dark Default",
     "workbench.iconTheme": "material-icon-theme",
     "workbench.editor.enablePreview": false,
     
     "terminal.integrated.defaultProfile.osx": "zsh",
     "terminal.integrated.fontFamily": "MesloLGS NF",
     "terminal.integrated.fontSize": 13,
     
     "git.autofetch": true,
     "git.confirmSync": false,
     "git.enableSmartCommit": true,
     
     "python.formatting.provider": "black",
     "python.linting.enabled": true,
     "python.linting.pylintEnabled": true,
     "python.linting.mypyEnabled": true,
     "python.terminal.activateEnvironment": true,
     
     "[python]": {
       "editor.defaultFormatter": "ms-python.black-formatter",
       "editor.formatOnSave": true,
       "editor.codeActionsOnSave": {
         "source.organizeImports": true
       }
     },
     
     "markdown.preview.fontSize": 14,
     
     "explorer.confirmDelete": false,
     "explorer.confirmDragAndDrop": false,
     
     "todo-tree.general.tags": [
       "BUG",
       "HACK",
       "FIXME",
       "TODO",
       "XXX",
       "[ ]",
       "[x]"
     ],
     
     "cSpell.userWords": [],
     
     "telemetry.telemetryLevel": "off"
   }
   EOF
   
   # Configure keybindings
   cat > ~/Library/Application\ Support/Code/User/keybindings.json << EOF
   [
     {
       "key": "cmd+d",
       "command": "editor.action.copyLinesDownAction",
       "when": "editorTextFocus && !editorReadonly"
     },
     {
       "key": "shift+alt+down",
       "command": "-editor.action.copyLinesDownAction",
       "when": "editorTextFocus && !editorReadonly"
     },
     {
       "key": "cmd+shift+k",
       "command": "editor.action.deleteLines",
       "when": "editorTextFocus && !editorReadonly"
     },
     {
       "key": "cmd+shift+d",
       "command": "editor.action.duplicateSelection"
     }
   ]
   EOF
   
   echo "VS Code has been configured successfully."
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x configure_vscode.sh
   ./configure_vscode.sh
   ```

## Step 4: Configure VS Code for Python Development

1. Create a script to configure VS Code for Python:
   ```bash
   cd ~/Developer/setup-scripts
   nano configure_vscode_python.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Configure Python-specific settings
   cat > ~/Library/Application\ Support/Code/User/python.code-snippets << EOF
   {
     "Main function": {
       "prefix": "main",
       "body": [
         "def main():",
         "    $0",
         "",
         "",
         "if __name__ == \"__main__\":",
         "    main()"
       ],
       "description": "Create a main function with if __name__ == \"__main__\" guard"
     },
     "Print variable": {
       "prefix": "printv",
       "body": [
         "print(f\"$1 = {$1}\")"
       ],
       "description": "Print a variable with its name and value"
     },
     "Create class": {
       "prefix": "class",
       "body": [
         "class $1:",
         "    \"\"\"",
         "    $2",
         "    \"\"\"",
         "    ",
         "    def __init__(self, $3):",
         "        $0",
         "    ",
         "    def __str__(self):",
         "        return f\"$1({self.__dict__})\"",
         "    ",
         "    def __repr__(self):",
         "        return self.__str__()",
         ""
       ],
       "description": "Create a Python class with __init__, __str__, and __repr__ methods"
     }
   }
   EOF
   
   echo "VS Code has been configured for Python development."
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x configure_vscode_python.sh
   ./configure_vscode_python.sh
   ```

## Step 5: Set Up Git Configuration

1. Create a script to configure Git:
   ```bash
   cd ~/Developer/setup-scripts
   nano setup_git.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Prompt for Git configuration
   read -p "Enter your Git username: " GIT_USERNAME
   read -p "Enter your Git email: " GIT_EMAIL
   
   # Configure Git
   git config --global user.name "$GIT_USERNAME"
   git config --global user.email "$GIT_EMAIL"
   
   # Configure Git defaults
   git config --global init.defaultBranch main
   git config --global pull.rebase true
   git config --global core.editor "code --wait"
   git config --global core.autocrlf input
   
   # Configure Git aliases
   git config --global alias.st status
   git config --global alias.co checkout
   git config --global alias.br branch
   git config --global alias.ci commit
   git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
   git config --global alias.unstage "reset HEAD --"
   git config --global alias.last "log -1 HEAD"
   git config --global alias.amend "commit --amend"
   
   # Create global .gitignore
   cat > ~/.gitignore_global << EOF
   # macOS
   .DS_Store
   .AppleDouble
   .LSOverride
   ._*
   
   # VS Code
   .vscode/*
   !.vscode/settings.json
   !.vscode/tasks.json
   !.vscode/launch.json
   !.vscode/extensions.json
   
   # Python
   __pycache__/
   *.py[cod]
   *$py.class
   *.so
   .Python
   env/
   build/
   develop-eggs/
   dist/
   downloads/
   eggs/
   .eggs/
   lib/
   lib64/
   parts/
   sdist/
   var/
   *.egg-info/
   .installed.cfg
   *.egg
   .pytest_cache/
   .coverage
   htmlcov/
   .tox/
   .coverage.*
   .cache
   
   # Virtual Environments
   .env
   .venv
   env/
   venv/
   ENV/
   
   # Jupyter Notebooks
   .ipynb_checkpoints
   
   # IDE-specific
   .idea/
   *.swp
   *.swo
   
   # Docker
   .docker/
   EOF
   
   git config --global core.excludesfile ~/.gitignore_global
   
   echo "Git has been configured successfully!"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x setup_git.sh
   ./setup_git.sh
   ```

## Step 6: Configure SSH for GitHub

1. Create a script to set up SSH for GitHub:
   ```bash
   cd ~/Developer/setup-scripts
   nano setup_github_ssh.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Generate SSH key for GitHub
   read -p "Enter your email for GitHub SSH key: " GITHUB_EMAIL
   
   # Create SSH directory if it doesn't exist
   mkdir -p ~/.ssh
   
   # Generate SSH key
   ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f ~/.ssh/github_ed25519
   
   # Add SSH key to SSH agent
   eval "$(ssh-agent -s)"
   touch ~/.ssh/config
   
   # Configure SSH config
   cat > ~/.ssh/config << EOF
   Host github.com
     AddKeysToAgent yes
     UseKeychain yes
     IdentityFile ~/.ssh/github_ed25519
   EOF
   
   # Add SSH key to keychain
   ssh-add --apple-use-keychain ~/.ssh/github_ed25519
   
   # Display public key
   echo "Your public SSH key is:"
   echo ""
   cat ~/.ssh/github_ed25519.pub
   echo ""
   echo "Copy this key and add it to your GitHub account:"
   echo "1. Go to GitHub.com and log in"
   echo "2. Click your profile picture and select 'Settings'"
   echo "3. In the left sidebar, click 'SSH and GPG keys'"
   echo "4. Click 'New SSH key'"
   echo "5. Add a title, paste your key, and click 'Add SSH key'"
   
   # Ask if the user wants to test the connection
   read -p "Do you want to test the connection to GitHub? (y/n): " TEST_CONNECTION
   
   if [ "$TEST_CONNECTION" = "y" ] || [ "$TEST_CONNECTION" = "Y" ]; then
     ssh -T git@github.com
   fi
   
   echo "SSH key for GitHub has been set up successfully!"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x setup_github_ssh.sh
   ./setup_github_ssh.sh
   ```

## Step 7: Set Up GitHub CLI

1. Install GitHub CLI:
   ```bash
   brew install gh
   ```

2. Authenticate with GitHub:
   ```bash
   gh auth login
   ```

3. Follow the prompts to complete the authentication process.

## Step 8: Set Up VS Code Dev Containers Configuration

1. Create a script to set up VS Code Dev Containers:
   ```bash
   cd ~/Developer/setup-scripts
   nano setup_vscode_devcontainers.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create directory for .devcontainer templates
   mkdir -p ~/Developer/vscode-templates
   
   # Create Python development container configuration
   mkdir -p ~/Developer/vscode-templates/python-devcontainer
   
   # Create devcontainer.json
   cat > ~/Developer/vscode-templates/python-devcontainer/devcontainer.json << EOF
   {
     "name": "Python Development",
     "dockerComposeFile": "docker-compose.yml",
     "service": "app",
     "workspaceFolder": "/app",
     "customizations": {
       "vscode": {
         "extensions": [
           "ms-python.python",
           "ms-python.vscode-pylance",
           "ms-azuretools.vscode-docker",
           "ms-python.black-formatter",
           "matangover.mypy",
           "ms-toolsai.jupyter",
           "streetsidesoftware.code-spell-checker",
           "eamodio.gitlens"
         ],
         "settings": {
           "python.formatting.provider": "black",
           "python.linting.enabled": true,
           "python.linting.mypyEnabled": true,
           "editor.formatOnSave": true,
           "editor.codeActionsOnSave": {
             "source.organizeImports": true
           }
         }
       }
     },
     "remoteUser": "root",
     "forwardPorts": [8000, 8888],
     "postCreateCommand": "pip install -r requirements.txt"
   }
   EOF
   
   # Create docker-compose.yml
   cat > ~/Developer/vscode-templates/python-devcontainer/docker-compose.yml << EOF
   version: '3.8'
   
   services:
     app:
       build: 
         context: .
         dockerfile: Dockerfile
       volumes:
         - ..:/app
       command: sleep infinity
       environment:
         - PYTHONUNBUFFERED=1
   EOF
   
   # Create Dockerfile
   cat > ~/Developer/vscode-templates/python-devcontainer/Dockerfile << EOF
   FROM python:3.12-slim
   
   WORKDIR /app
   
   # Install system dependencies
   RUN apt-get update && apt-get install -y \\
       build-essential \\
       curl \\
       git \\
       && rm -rf /var/lib/apt/lists/*
   
   # Install Python packages
   COPY requirements.txt /tmp/
   RUN pip install --no-cache-dir -r /tmp/requirements.txt
   
   # Create non-root user
   ARG USERNAME=vscode
   ARG USER_UID=1000
   ARG USER_GID=\$USER_UID
   
   RUN groupadd --gid \$USER_GID \$USERNAME \\
       && useradd --uid \$USER_UID --gid \$USER_GID -m \$USERNAME
   
   # Set the default user
   USER \$USERNAME
   EOF
   
   # Create requirements.txt
   cat > ~/Developer/vscode-templates/python-devcontainer/requirements.txt << EOF
   # Development tools
   black
   isort
   mypy
   pytest
   pytest-cov
   
   # Common libraries
   numpy
   pandas
   matplotlib
   requests
   python-dotenv
   EOF
   
   # Create a script to copy .devcontainer to a project
   cat > ~/Developer/vscode-templates/add_devcontainer.sh << EOF
   #!/bin/bash
   
   if [ \$# -lt 1 ]; then
     echo "Usage: \$0 <project_directory> [template_name]"
     echo "Available templates: python-devcontainer"
     exit 1
   fi
   
   PROJECT_DIR="\$1"
   TEMPLATE_NAME="\${2:-python-devcontainer}"
   
   # Check if project directory exists
   if [ ! -d "\$PROJECT_DIR" ]; then
     echo "Project directory does not exist: \$PROJECT_DIR"
     exit 1
   fi
   
   # Check if template exists
   TEMPLATE_DIR=~/Developer/vscode-templates/"\$TEMPLATE_NAME"
   if [ ! -d "\$TEMPLATE_DIR" ]; then
     echo "Template does not exist: \$TEMPLATE_NAME"
     exit 1
   fi
   
   # Create .devcontainer directory in project
   mkdir -p "\$PROJECT_DIR/.devcontainer"
   
   # Copy template files to project
   cp -r "\$TEMPLATE_DIR"/* "\$PROJECT_DIR/.devcontainer/"
   
   echo "Dev Container configuration has been added to \$PROJECT_DIR"
   echo "Open the project in VS Code and use 'Reopen in Container' to start development"
   EOF
   
   # Make the script executable
   chmod +x ~/Developer/vscode-templates/add_devcontainer.sh
   
   # Create an alias for the script
   echo "alias add-devcontainer='~/Developer/vscode-templates/add_devcontainer.sh'" >> ~/.zshrc
   
   echo "VS Code Dev Containers configuration has been set up successfully!"
   echo "To add a Dev Container to a project, run: add-devcontainer <project_directory>"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x setup_vscode_devcontainers.sh
   ./setup_vscode_devcontainers.sh
   ```

## Step 9: Set Up .dotfiles Repository

1. Create a script to set up a .dotfiles repository:
   ```bash
   cd ~/Developer/setup-scripts
   nano setup_dotfiles.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create dotfiles directory
   mkdir -p ~/.dotfiles
   
   # Initialize Git repository
   cd ~/.dotfiles
   git init
   
   # Create README
   cat > README.md << EOF
   # Dotfiles
   
   Personal configuration files for macOS.
   
   ## Contents
   
   - Shell configuration (.zshrc)
   - Git configuration (.gitconfig)
   - Vim configuration (.vimrc)
   - VSCode settings
   - Terminal settings
   EOF
   
   # Copy configuration files
   cp ~/.zshrc ~/.dotfiles/
   cp ~/.gitconfig ~/.dotfiles/
   cp ~/.vimrc ~/.dotfiles/ 2>/dev/null || touch ~/.dotfiles/.vimrc
   
   # Copy VS Code settings
   mkdir -p ~/.dotfiles/vscode
   cp ~/Library/Application\ Support/Code/User/settings.json ~/.dotfiles/vscode/
   cp ~/Library/Application\ Support/Code/User/keybindings.json ~/.dotfiles/vscode/
   
   # Create script to install dotfiles
   cat > install.sh << EOF
   #!/bin/bash
   
   # Create symbolic links
   ln -sf \$(pwd)/.zshrc ~/.zshrc
   ln -sf \$(pwd)/.gitconfig ~/.gitconfig
   ln -sf \$(pwd)/.vimrc ~/.vimrc
   
   # Copy VS Code settings
   mkdir -p ~/Library/Application\ Support/Code/User
   cp \$(pwd)/vscode/settings.json ~/Library/Application\ Support/Code/User/
   cp \$(pwd)/vscode/keybindings.json ~/Library/Application\ Support/Code/User/
   
   echo "Dotfiles installed successfully!"
   EOF
   
   # Make install script executable
   chmod +x install.sh
   
   # Initial commit
   git add .
   git commit -m "Initial commit"
   
   echo "Dotfiles repository has been set up successfully!"
   echo "To track additional files, copy them to ~/.dotfiles and add them to Git."
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x setup_dotfiles.sh
   ./setup_dotfiles.sh
   ```

## Summary

This setup guide provides a comprehensive approach to setting up VS Code and GitHub on your MacBook Pro M3 Max. The key components include:

1. **VS Code Installation and Configuration** with essential extensions and optimized settings
2. **Git Configuration** with useful aliases and a global gitignore file
3. **GitHub SSH Key Setup** for secure authentication
4. **GitHub CLI Installation** for command-line interaction with GitHub
5. **VS Code Dev Containers Configuration** for isolated development environments
6. **Dotfiles Repository Setup** for backing up and syncing your configuration

These steps will provide you with a powerful development environment that is ready for integration with Docker for containerized development.

## Usage Examples

### Add Dev Container to an Existing Project

```bash
add-devcontainer ~/Developer/my-project
```

### Clone a GitHub Repository

```bash
gh repo clone owner/repository
```

### Create a New GitHub Repository

```bash
gh repo create my-new-repo --public
```

### Initialize a Git Repository and Push to GitHub

```bash
cd my-project
git init
git add .
git commit -m "Initial commit"
gh repo create my-project --source=. --public
git push -u origin main
```