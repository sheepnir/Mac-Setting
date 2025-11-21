# Step 3 - Development Environment Setup

This guide will walk you through setting up your Mac for Python, HTML, CSS, and JavaScript development. We'll focus on creating project-specific environments, managing GitHub repositories, and configuring VS Code for optimal development workflow.

## Step 1: Install Development Tools

First, let's install the core development tools using Homebrew:

```bash
# Create a development tools installation script
cat > ~/Developer/setup-scripts/install_dev_tools.sh << 'EOF'
#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Installing Python development tools...${NC}"

# Install Python using pyenv for version management
brew install pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# Install latest stable Python versions
pyenv install 3.12.0
pyenv global 3.12.0

# Install pipx for isolated Python application installation
brew install pipx
pipx ensurepath

# Install Poetry for dependency management
pipx install poetry

# Install development tools
echo -e "${YELLOW}Installing web development tools...${NC}"
brew install node
brew install yarn
brew install typescript

echo -e "${YELLOW}Installing Git tools...${NC}"
brew install git
brew install git-lfs

echo -e "${YELLOW}Installing additional development tools...${NC}"
brew install jq
brew install direnv

echo -e "${GREEN}Development tools installation complete!${NC}"
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/install_dev_tools.sh

# Run the script
~/Developer/setup-scripts/install_dev_tools.sh
```

## Step 2: Configure Python Virtual Environment Tools

Let's set up tools for creating isolated Python environments:

```bash
# Create a Python environment setup script
cat > ~/Developer/setup-scripts/configure_python_env.sh << 'EOF'
#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Configuring Python environment tools...${NC}"

# Configure Poetry
poetry config virtualenvs.in-project true
poetry config virtualenvs.path ".venv"

# Install common Python development packages globally with pipx
pipx install black
pipx install flake8
pipx install mypy
pipx install isort
pipx install pre-commit
pipx install pytest

# Configure direnv for environment management
if ! grep -q "eval \"\$(direnv hook zsh)\"" ~/.zshrc; then
  echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
fi

# Create common .gitignore template for Python projects
mkdir -p ~/Developer/templates
cat > ~/Developer/templates/python-gitignore << 'EOT'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
.venv/
venv/
ENV/
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

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# VS Code
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json

# Environments
.env
.envrc

# Node.js
node_modules/
npm-debug.log
yarn-debug.log
yarn-error.log

# macOS
.DS_Store
.AppleDouble
.LSOverride
EOT

# Create .envrc template for direnv
cat > ~/Developer/templates/python-envrc << 'EOT'
# Set environment variables for this project
# export SECRET_KEY="development_key"

# Add local bin directory to PATH
PATH_add bin

# Load Python virtual environment if it exists
if [ -d .venv ]; then
  source .venv/bin/activate
fi
EOT

# Create poetry.toml template
cat > ~/Developer/templates/poetry.toml << 'EOT'
[virtualenvs]
in-project = true
path = ".venv"
EOT

echo -e "${GREEN}Python environment tools configuration complete!${NC}"
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/configure_python_env.sh

# Run the script
~/Developer/setup-scripts/configure_python_env.sh
```

## Step 3: Configure VS Code for Python and Web Development

Now let's set up VS Code with extensions and settings optimized for Python and web development:

```bash
# Create VS Code setup script
cat > ~/Developer/setup-scripts/setup_vscode.sh << 'EOF'
#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Installing VS Code extensions...${NC}"

# Python development
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.black-formatter
code --install-extension matangover.mypy
code --install-extension ms-python.flake8

# Web development
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension ritwickdey.LiveServer
code --install-extension bradlc.vscode-tailwindcss

# General development
code --install-extension eamodio.gitlens
code --install-extension GitHub.copilot
code --install-extension yzhang.markdown-all-in-one
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension mechatroner.rainbow-csv

# Configure VS Code settings
mkdir -p "$HOME/Library/Application Support/Code/User"
cat > "$HOME/Library/Application Support/Code/User/settings.json" << 'EOT'
{
    "editor.fontSize": 14,
    "editor.fontFamily": "JetBrains Mono, Menlo, Monaco, 'Courier New', monospace",
    "editor.fontLigatures": true,
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": "explicit"
    },
    "editor.rulers": [88],
    "editor.minimap.enabled": true,
    "editor.tabSize": 4,
    "editor.bracketPairColorization.enabled": true,
    "editor.guides.bracketPairs": true,
    
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,
    "files.autoSave": "onFocusChange",
    
    "terminal.integrated.defaultProfile.osx": "zsh",
    "terminal.integrated.fontSize": 13,
    
    // Python settings
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
    "python.analysis.typeCheckingMode": "basic",
    "python.languageServer": "Pylance",
    "python.formatting.provider": "black",
    "python.formatting.blackPath": "${env:HOME}/.local/bin/black",
    "python.linting.enabled": true,
    "python.linting.flake8Enabled": true,
    "python.linting.flake8Path": "${env:HOME}/.local/bin/flake8",
    "python.linting.mypyEnabled": true,
    "python.linting.mypyPath": "${env:HOME}/.local/bin/mypy",
    "python.testing.pytestEnabled": true,
    
    // Web development settings
    "html.format.wrapLineLength": 100,
    "css.lint.importStatement": "warning",
    "javascript.updateImportsOnFileMove.enabled": "always",
    "javascript.format.enable": true,
    "javascript.suggestionActions.enabled": false,
    
    // Git settings
    "git.autofetch": true,
    "git.enableSmartCommit": true,
    "gitlens.codeLens.enabled": true,
    
    // Miscellaneous settings
    "workbench.startupEditor": "none",
    "workbench.colorTheme": "Default Dark+",
    "workbench.iconTheme": "vs-seti",
    "breadcrumbs.enabled": true,
    "explorer.confirmDelete": false,
    "explorer.confirmDragAndDrop": false,
    "window.newWindowDimensions": "maximized",
    "telemetry.telemetryLevel": "off"
}
EOT

# Create VS Code launch configuration template
mkdir -p ~/Developer/templates/.vscode
cat > ~/Developer/templates/.vscode/launch.json << 'EOT'
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": false
        },
        {
            "name": "Python: Module",
            "type": "python",
            "request": "launch",
            "module": "module_name",
            "justMyCode": false
        },
        {
            "name": "Python: Flask",
            "type": "python",
            "request": "launch",
            "module": "flask",
            "env": {
                "FLASK_APP": "app.py",
                "FLASK_DEBUG": "1"
            },
            "args": [
                "run",
                "--no-debugger"
            ],
            "jinja": true,
            "justMyCode": false
        }
    ]
}
EOT

# Create VS Code tasks configuration template
cat > ~/Developer/templates/.vscode/tasks.json << 'EOT'
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Run Tests",
            "type": "shell",
            "command": "${workspaceFolder}/.venv/bin/python -m pytest",
            "group": {
                "kind": "test",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always",
                "panel": "new"
            }
        },
        {
            "label": "Format Code",
            "type": "shell",
            "command": "${workspaceFolder}/.venv/bin/python -m black .",
            "group": "none",
            "presentation": {
                "reveal": "always",
                "panel": "new"
            }
        }
    ]
}
EOT

echo -e "${GREEN}VS Code configuration complete!${NC}"
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/setup_vscode.sh

# Run the script
~/Developer/setup-scripts/setup_vscode.sh
```

## Step 4: Create Project Setup Scripts

Let's create scripts to automate new project setup:

```bash
# Create script for setting up a new Python project
cat > ~/Developer/setup-scripts/new_python_project.sh << 'EOF'
#!/bin/bash

# Check if project name is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <project-name> [description]"
    exit 1
fi

PROJECT_NAME=$1
DESCRIPTION=${2:-"A Python project"}
PROJECT_DIR="$HOME/Developer/$PROJECT_NAME"

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Creating new Python project: ${BLUE}$PROJECT_NAME${NC}"

# Create project directory
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit

# Create project structure
mkdir -p "$PROJECT_NAME/tests"
touch "$PROJECT_NAME/__init__.py"
touch "$PROJECT_NAME/tests/__init__.py"

# Initialize Git repository
git init

# Copy .gitignore
cp ~/Developer/templates/python-gitignore .gitignore

# Create README.md
cat > README.md << EOT
# $PROJECT_NAME

$DESCRIPTION

## Installation

\`\`\`bash
# Clone the repository
git clone https://github.com/yourusername/$PROJECT_NAME.git
cd $PROJECT_NAME

# Set up the environment
poetry install
\`\`\`

## Usage

\`\`\`python
from $PROJECT_NAME import main

# Add usage examples here
\`\`\`

## Development

This project uses Poetry for dependency management and packaging.

\`\`\`bash
# Install development dependencies
poetry install

# Run tests
poetry run pytest
\`\`\`
EOT

# Initialize Poetry
poetry init --name "$PROJECT_NAME" --description "$DESCRIPTION" --author "Your Name <your.email@example.com>" --dev-dependency pytest --dev-dependency black --dev-dependency flake8 --dev-dependency mypy --no-interaction

# Create main module file
cat > "$PROJECT_NAME/main.py" << EOT
"""Main module for $PROJECT_NAME."""


def main():
    """Run the main function."""
    print("Hello from $PROJECT_NAME!")


if __name__ == "__main__":
    main()
EOT

# Create a simple test
cat > "$PROJECT_NAME/tests/test_main.py" << EOT
"""Tests for the main module."""
from $PROJECT_NAME import main


def test_main():
    """Test the main function."""
    # Add actual tests here
    assert True
EOT

# Create .env file
cat > .env << EOT
# Environment variables for $PROJECT_NAME
# Add your environment variables here
EOT

# Set up direnv
cp ~/Developer/templates/python-envrc .envrc
direnv allow .

# Set up VSCode
mkdir -p .vscode
cp ~/Developer/templates/.vscode/launch.json .vscode/
cp ~/Developer/templates/.vscode/tasks.json .vscode/

# Create settings.json
cat > .vscode/settings.json << EOT
{
    "python.defaultInterpreterPath": "\${workspaceFolder}/.venv/bin/python",
    "python.formatting.provider": "black",
    "python.linting.enabled": true,
    "python.linting.flake8Enabled": true,
    "python.linting.mypyEnabled": true,
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": "explicit"
    },
    "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter"
    }
}
EOT

# Initialize pre-commit
cat > .pre-commit-config.yaml << EOT
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
    -   id: trailing-whitespace
    -   id: end-of-file-fixer
    -   id: check-yaml
    -   id: check-added-large-files

-   repo: https://github.com/pycqa/isort
    rev: 5.12.0
    hooks:
    -   id: isort

-   repo: https://github.com/psf/black
    rev: 23.3.0
    hooks:
    -   id: black
        args: [--line-length=88]

-   repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
    -   id: flake8
        additional_dependencies: [flake8-docstrings]
EOT

# Set up Poetry environment
poetry install

# Initialize pre-commit
pre-commit install

echo -e "${GREEN}Project setup complete!${NC}"
echo -e "Your project is ready at: ${BLUE}$PROJECT_DIR${NC}"
echo
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Create a GitHub repository: ${BLUE}gh repo create $PROJECT_NAME --public${NC}"
echo -e "2. Add remote and push: ${BLUE}git add . && git commit -m \"Initial commit\" && git push -u origin main${NC}"
echo -e "3. Open VS Code: ${BLUE}code .${NC}"
EOF

# Create script for setting up a new web project
cat > ~/Developer/setup-scripts/new_web_project.sh << 'EOF'
#!/bin/bash

# Check if project name is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <project-name> [description]"
    exit 1
fi

PROJECT_NAME=$1
DESCRIPTION=${2:-"A web development project"}
PROJECT_DIR="$HOME/Developer/$PROJECT_NAME"

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Creating new web project: ${BLUE}$PROJECT_NAME${NC}"

# Create project directory
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit

# Initialize Git repository
git init

# Create basic project structure
mkdir -p css js img

# Create index.html
cat > index.html << EOT
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$PROJECT_NAME</title>
    <link rel="stylesheet" href="css/styles.css">
    <script src="js/main.js" defer></script>
</head>
<body>
    <header>
        <h1>$PROJECT_NAME</h1>
    </header>
    
    <main>
        <p>Welcome to $PROJECT_NAME</p>
    </main>
    
    <footer>
        <p>&copy; $(date +%Y) Your Name</p>
    </footer>
</body>
</html>
EOT

# Create CSS file
cat > css/styles.css << EOT
/* Base styles for $PROJECT_NAME */

:root {
    --primary-color: #3498db;
    --secondary-color: #2ecc71;
    --dark-color: #2c3e50;
    --light-color: #ecf0f1;
    --font-main: 'Helvetica Neue', Helvetica, Arial, sans-serif;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: var(--font-main);
    line-height: 1.6;
    color: var(--dark-color);
    background-color: var(--light-color);
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
}

header, footer {
    padding: 20px;
    text-align: center;
}

main {
    padding: 40px 20px;
}

h1 {
    color: var(--primary-color);
}

footer {
    margin-top: 40px;
    font-size: 0.9rem;
    color: #7f8c8d;
}
EOT

# Create JavaScript file
cat > js/main.js << EOT
/**
 * Main JavaScript file for $PROJECT_NAME
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log('$PROJECT_NAME loaded successfully!');
    
    // Your code here
});
EOT

# Create README.md
cat > README.md << EOT
# $PROJECT_NAME

$DESCRIPTION

## Overview

This is a web development project that includes:
- HTML5
- CSS3
- JavaScript

## Structure

\`\`\`
$PROJECT_NAME/
├── index.html    # Main HTML file
├── css/          # CSS stylesheets
│   └── styles.css
├── js/           # JavaScript files
│   └── main.js
└── img/          # Images directory
\`\`\`

## Getting Started

1. Clone the repository
2. Open \`index.html\` in your browser

## Development

- Use VS Code's Live Server extension to preview changes in real-time
EOT

# Create .gitignore
cat > .gitignore << EOT
# Node.js
node_modules/
npm-debug.log
yarn-debug.log
yarn-error.log

# Editor folders
.vscode/*
!.vscode/settings.json
!.vscode/extensions.json

# System files
.DS_Store
Thumbs.db

# Environment variables
.env
EOT

# Set up VSCode
mkdir -p .vscode
cat > .vscode/settings.json << EOT
{
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "liveServer.settings.donotShowInfoMsg": true,
    "liveServer.settings.donotVerifyTags": true,
    "css.validate": true,
    "javascript.format.enable": true,
    "html.format.wrapLineLength": 100,
    "files.associations": {
        "*.css": "css",
        "*.js": "javascript"
    }
}
EOT

cat > .vscode/extensions.json << EOT
{
    "recommendations": [
        "esbenp.prettier-vscode",
        "ritwickdey.LiveServer",
        "dbaeumer.vscode-eslint",
        "streetsidesoftware.code-spell-checker"
    ]
}
EOT

echo -e "${GREEN}Web project setup complete!${NC}"
echo -e "Your project is ready at: ${BLUE}$PROJECT_DIR${NC}"
echo
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Create a GitHub repository: ${BLUE}gh repo create $PROJECT_NAME --public${NC}"
echo -e "2. Add remote and push: ${BLUE}git add . && git commit -m \"Initial commit\" && git push -u origin main${NC}"
echo -e "3. Open VS Code: ${BLUE}code .${NC}"
echo -e "4. Start Live Server by right-clicking on index.html and selecting 'Open with Live Server'"
EOF

# Make scripts executable
chmod +x ~/Developer/setup-scripts/new_python_project.sh
chmod +x ~/Developer/setup-scripts/new_web_project.sh

# Add aliases to .zshrc
cat >> ~/.zshrc << 'EOT'

# Development project aliases
alias newpy="~/Developer/setup-scripts/new_python_project.sh"
alias newweb="~/Developer/setup-scripts/new_web_project.sh"
EOT
```

## Step 5: Create Workflow Guide for Python Projects

Let's create a guide for your Python workflow:

```bash
# Create Python workflow guide
mkdir -p ~/Developer/guides
cat > ~/Developer/guides/python_workflow.md << 'EOT'
# Python Development Workflow Guide

This guide outlines the recommended workflow for Python projects.

## Starting a New Project

1. Create a new project using the provided script:
   ```bash
   newpy my-project "Description of my project"
   ```

2. Create a GitHub repository:
   ```bash
   cd ~/Developer/my-project
   gh repo create my-project --public --source=.
   git push -u origin main
   ```

3. Open in VS Code:
   ```bash
   code .
   ```

## Project Structure

A typical Python project structure:

```
my-project/
├── .git/                   # Git repository
├── .venv/                  # Virtual environment (created by Poetry)
├── .vscode/                # VS Code settings
├── my_project/             # Main package
│   ├── __init__.py         # Package initializer
│   ├── main.py             # Main module
│   └── tests/              # Test directory
│       ├── __init__.py     # Test package initializer
│       └── test_main.py    # Tests for main module
├── .env                    # Environment variables
├── .envrc                  # Direnv configuration
├── .gitignore              # Git ignore rules
├── .pre-commit-config.yaml # Pre-commit hooks
├── README.md               # Project documentation
└── pyproject.toml          # Poetry project and dependency definition
```

## Daily Development Workflow

1. **Activate Environment Automatically**
   - With direnv set up, your environment will activate automatically when you enter the project directory

2. **Install Dependencies**
   ```bash
   poetry install
   ```

3. **Add New Dependencies**
   ```bash
   # For regular dependencies
   poetry add package-name
   
   # For development dependencies
   poetry add --group dev package-name
   ```

4. **Run Tests**
   ```bash
   poetry run pytest
   ```
   Alternatively, use VS Code's Test Explorer

5. **Format Code**
   ```bash
   poetry run black .
   ```
   Or just save your file in VS Code with format-on-save enabled

6. **Run Linting**
   ```bash
   poetry run flake8
   poetry run mypy
   ```

7. **Run Your Application**
   ```bash
   poetry run python -m my_project.main
   ```

8. **Commit Changes**
   ```bash
   git add .
   git commit -m "Descriptive message about changes"
   git push
   ```
   Pre-commit hooks will check your code before committing

## Working with Multiple Python Versions

To run your project with different Python versions:

1. Install the Python version with pyenv:
   ```bash
   pyenv install 3.11.0
   ```

2. Create a project-specific Python version:
   ```bash
   cd ~/Developer/my-project
   pyenv local 3.11.0
   ```

3. Re-create your Poetry environment:
   ```bash
   poetry env use python
   poetry install
   ```

## Packaging and Distribution

To build your package for distribution:

```bash
poetry build
```

This will create distribution files in the `dist/` directory.

To publish to PyPI:

```bash
poetry publish
```

## Best Practices

1. **Documentation**:
   - Document your code with docstrings and maintain the README file
   - For larger projects, consider using Sphinx for comprehensive documentation

2. **Testing**:
   - Aim for high test coverage
   - Write tests before implementing features (TDD)
   - Use pytest fixtures for reusable test components

3. **Version Control**:
   - Create feature branches for new work
   - Use pull requests for code review
   - Follow semantic versioning for releases

4. **Code Quality**:
   - Follow PEP 8 style guidelines (enforced by black and flake8)
   - Use type hints and verify with mypy
   - Run pre-commit hooks before pushing code

5. **Security**:
   - Store secrets in .env files (never commit these)
   - Use pipx to isolate command-line applications
   - Regularly update dependencies with `poetry update`
EOT

# Create Web Development workflow guide
cat > ~/Developer/guides/web_workflow.md << 'EOT'
# Web Development Workflow Guide

This guide outlines the recommended workflow for HTML, CSS, and JavaScript projects.

## Starting a New Project

1. Create a new project using the provided script:
   ```bash
   newweb my-website "Description of my website"
   ```

2. Create a GitHub repository:
   ```bash
   cd ~/Developer/my-website
   gh repo create my-website --public --source=.
   git push -u origin main
   ```

3. Open in VS Code:
   ```bash
   code .
   ```

## Project Structure

A basic web project structure:

```
my-website/
├── .git/           # Git repository
├── .vscode/        # VS Code settings
├── css/            # CSS stylesheets
│   └── styles.css
├── img/            # Images directory
├── js/             # JavaScript files
│   └── main.js
├── .gitignore      # Git ignore rules
├── README.md       # Project documentation
└── index.html      # Main HTML file
```

## Daily Development Workflow

1. **Launch Live Server**
   - Right-click on `index.html` in VS Code
   - Select "Open with Live Server"
   - The page will open in your browser with automatic refreshing

2. **Working with HTML**
   - Follow semantic HTML practices
   - Validate your HTML with the W3C Validator

3. **Working with CSS**
   - Organize your CSS with a consistent structure
   - Use CSS variables for themes and reusable values
   - Consider using a CSS methodology like BEM for larger projects

4. **Working with JavaScript**
   - Write modular JavaScript code
   - Use ES6+ features
   - Consider using npm and bundlers for larger projects

5. **Version Control**
   ```bash
   git add .
   git commit -m "Descriptive message about changes"
   git push
   ```

## Expanding Your Project

When your project grows, consider these enhancements:

1. **Adding npm for Package Management**
   ```bash
   npm init
   ```

2. **Adding Sass for Enhanced CSS**
   ```bash
   npm install sass --save-dev
   ```

3. **Adding ESLint for JavaScript Linting**
   ```bash
   npm install eslint --save-dev
   npx eslint --init
   ```

4. **Adding Prettier for Code Formatting**
   ```bash
   npm install prettier --save-dev
   ```

5. **Adding a Build Process with Parcel**
   ```bash
   npm install parcel --save-dev
   ```
   
   Update your scripts in package.json:
   ```json
   "scripts": {
     "dev": "parcel index.html",
     "build": "parcel build index.html"
   }
   ```

## Best Practices

1. **Responsive Design**
   - Use mobile-first approach
   - Test on multiple devices and screen sizes
   - Use media queries for breakpoints

2. **Performance**
   - Optimize images
   - Minimize HTTP requests
   - Use lazy loading for images and heavy resources

3. **Accessibility**
   - Use semantic HTML
   - Include proper ARIA attributes
   - Ensure sufficient color contrast
   - Make sure your site is keyboard navigable

4. **Cross-Browser Compatibility**
   - Test on multiple browsers
   - Use feature detection instead of browser detection
   - Consider using polyfills for newer features

5. **SEO Best Practices**
   - Use appropriate heading structure
   - Include meta tags
   - Create a sitemap.xml and robots.txt
EOT

# Create VS Code extensions guide
cat > ~/Developer/guides/vscode_extensions.md << 'EOT'
# VS Code Extensions for Development

This guide lists recommended VS Code extensions for Python and web development.

## Already Installed Extensions

The following extensions should already be installed from the setup script:

### Python Development
- **Python (ms-python.python)**: Python language support
- **Pylance (ms-python.vscode-pylance)**: Language server with enhanced features
- **Black Formatter (ms-python.black-formatter)**: Code formatting
- **Mypy Type Checker (matangover.mypy)**: Static type checking
- **Flake8 (ms-python.flake8)**: Code linting

### Web Development
- **ESLint (dbaeumer.vscode-eslint)**: JavaScript linting
- **Prettier (esbenp.prettier-vscode)**: Code formatting
- **Live Server (ritwickdey.LiveServer)**: Local development server with live reload
- **Tailwind CSS IntelliSense (bradlc.vscode-tailwindcss)**: Autocomplete for Tailwind

### General Development
- **GitLens (eamodio.gitlens)**: Enhanced Git capabilities
- **GitHub Copilot (GitHub.copilot)**: AI code suggestions
- **Markdown All in One (yzhang.markdown-all-in-one)**: Markdown support
- **Code Spell Checker (streetsidesoftware.code-spell-checker)**: Spell checking
- **Live Share (ms-vsliveshare.vsliveshare)**: Collaborative editing
- **Rainbow CSV (mechatroner.rainbow-csv)**: CSV file visualization

## Additional Recommended Extensions

### Python Development
- **Python Test Explorer (littlefoxteam.vscode-python-test-adapter)**: Test runner interface
- **Python Docstring Generator (njpwerner.autodocstring)**: Generate docstrings
- **Python Dependencies (ms-python.python-dependencies)**: Manage dependencies
- **Python Environment Manager (donjayamanne.python-environment-manager)**: Manage environments

### Web Development
- **HTML CSS Support (ecmel.vscode-html-css)**: HTML/CSS editing
- **CSS Peek (pranaygp.vscode-css-peek)**: View CSS definitions
- **Import Cost (wix.vscode-import-cost)**: Display import sizes
- **Path Intellisense (christian-kohler.path-intellisense)**: Autocomplete filenames
- **HTML Preview (george-alisson.html-preview-vscode)**: Preview HTML files

### Data Science
- **Jupyter (ms-toolsai.jupyter)**: Jupyter notebook support
- **Jupyter Keymap (ms-toolsai.jupyter-keymap)**: Jupyter keybindings
- **Jupyter Notebook Renderers (ms-toolsai.jupyter-renderers)**: Enhanced notebook display

### Productivity
- **Docker (ms-azuretools.vscode-docker)**: Docker integration
- **Remote - SSH (ms-vscode-remote.remote-ssh)**: Work on remote machines
- **Better Comments (aaron-bond.better-comments)**: Categorized comments
- **Todo Tree (Gruntfuggly.todo-tree)**: Track TODO comments
- **Bookmarks (alefragnani.Bookmarks)**: Add bookmarks in code
- **Project Manager (alefragnani.project-manager)**: Manage multiple projects

## Setting Up Custom VS Code Snippets

Create custom snippets for frequently used code:

1. In VS Code, press `Cmd+Shift+P`
2. Type "snippets" and select "Preferences: Configure User Snippets"
3. Select "New Global Snippets File" or a language-specific snippets file

Example Python snippets:

```json
{
    "Python Class": {
        "prefix": "pyclass",
        "body": [
            "class ${1:ClassName}:",
            "    \"\"\"${2:Class docstring.}\"\"\"",
            "    ",
            "    def __init__(self, ${3:args}):",
            "        \"\"\"Initialize the ${1:ClassName} instance.\"\"\"",
            "        ${0:pass}"
        ],
        "description": "Create a Python class with docstrings"
    },
    "Python Function": {
        "prefix": "pyfunc",
        "body": [
            "def ${1:function_name}(${2:args}):",
            "    \"\"\"${3:Function docstring.}\"\"\"",
            "    ${0:pass}"
        ],
        "description": "Create a Python function with docstring"
    }
}
```

## Configuring VS Code Keyboard Shortcuts

Customize your keyboard shortcuts for maximum productivity:

1. In VS Code, press `Cmd+Shift+P`
2. Type "keyboard" and select "Preferences: Open Keyboard Shortcuts"
3. Search for and customize any shortcut you use frequently

Recommended shortcuts to customize:
- Format document
- Run tests
- Toggle terminal
- Toggle sidebar
- Navigate between files
EOT

# Create a quick reference guide
cat > ~/Developer/guides/quick_reference.md << 'EOT'
# Development Quick Reference

## Python Project Commands

```bash
# Create new Python project
newpy project-name "Project description"

# Initialize Poetry in existing project
poetry init

# Add dependencies
poetry add package-name
poetry add --group dev package-name

# Install dependencies
poetry install

# Run Python script
poetry run python -m project_name.main

# Run tests
poetry run pytest

# Format code
poetry run black .

# Run linting
poetry run flake8
poetry run mypy

# Activate virtual environment (if not using direnv)
poetry shell
```

## Web Project Commands

```bash
# Create new web project
newweb project-name "Project description"

# Start Live Server
# Use VS Code extension or:
npx live-server

# Initialize npm in existing project
npm init -y

# Add Sass
npm install sass --save-dev
```

## Git Commands

```bash
# Create new repository
gh repo create repo-name --public

# Clone repository
gh repo clone username/repo-name

# Create branch
git checkout -b feature-name

# Commit changes
git add .
git commit -m "Commit message"
git push -u origin feature-name

# Create pull request
gh pr create
```

## VS Code Keyboard Shortcuts

| Action | Mac | Windows/Linux |
|--------|-----|---------------|
| Command Palette | Cmd+Shift+P | Ctrl+Shift+P |
| Quick Open | Cmd+P | Ctrl+P |
| Toggle Terminal | Ctrl+` | Ctrl+` |
| Toggle Sidebar | Cmd+B | Ctrl+B |
| Format Document | Shift+Alt+F | Shift+Alt+F |
| Go to Definition | F12 | F12 |
| Open Settings | Cmd+, | Ctrl+, |
| Save | Cmd+S | Ctrl+S |
| Split Editor | Cmd+\ | Ctrl+\ |
EOT
```

## Step 6: GitHub Templates and Workflows

Let's set up GitHub templates to streamline your workflow:

```bash
# Create a script for GitHub templates
cat > ~/Developer/setup-scripts/setup_github_templates.sh << 'EOF'
#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up GitHub templates...${NC}"

# Create templates directory
mkdir -p ~/Developer/templates/github

# Create issue template
mkdir -p ~/Developer/templates/github/ISSUE_TEMPLATE
cat > ~/Developer/templates/github/ISSUE_TEMPLATE/bug_report.md << 'EOT'
---
name: Bug report
about: Create a report to help improve the project
title: '[BUG] '
labels: bug
assignees: ''
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Environment (please complete the following information):**
 - OS: [e.g. macOS 14.0]
 - Python version: [e.g. 3.12.0]
 - Package version: [e.g. 1.0.0]

**Additional context**
Add any other context about the problem here.
EOT

cat > ~/Developer/templates/github/ISSUE_TEMPLATE/feature_request.md << 'EOT'
---
name: Feature request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.
EOT

# Create pull request template
cat > ~/Developer/templates/github/pull_request_template.md << 'EOT'
## Description
Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context.

Fixes # (issue)

## Type of change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## How Has This Been Tested?
Please describe the tests that you ran to verify your changes. Provide instructions so we can reproduce.

## Checklist:
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
EOT

# Create GitHub workflows
mkdir -p ~/Developer/templates/github/workflows

# Python workflow
cat > ~/Developer/templates/github/workflows/python-tests.yml << 'EOT'
name: Python Tests

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.11, 3.12]

    steps:
    - uses: actions/checkout@v3
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    - name: Install Poetry
      uses: snok/install-poetry@v1
      with:
        version: 1.5.1
    - name: Install dependencies
      run: |
        poetry install
    - name: Lint with flake8
      run: |
        poetry run flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
    - name: Type check with mypy
      run: |
        poetry run mypy .
    - name: Test with pytest
      run: |
        poetry run pytest
EOT

# Web workflow
cat > ~/Developer/templates/github/workflows/web-linting.yml << 'EOT'
name: Web Linting

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  lint:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Set up Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    - name: Install dependencies
      run: |
        npm ci
    - name: Lint with ESLint
      run: |
        npm run lint
    - name: Format check with Prettier
      run: |
        npm run format:check
EOT

echo -e "${GREEN}GitHub templates setup complete!${NC}"
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/setup_github_templates.sh

# Run the script
~/Developer/setup-scripts/setup_github_templates.sh
```

## Step 7: Auto-Launch Development Tools

Create a script to auto-launch your development environment:

```bash
# Create auto-launch script
cat > ~/Developer/setup-scripts/launch_dev_env.sh << 'EOF'
#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Launching development environment...${NC}"

# Open VS Code
open -a "Visual Studio Code"

# Open browser
open -a "Brave Browser"

# Open terminal
open -a "Warp"

# Open GitHub desktop if installed
if [ -d "/Applications/GitHub Desktop.app" ]; then
    open -a "GitHub Desktop"
fi

echo -e "${GREEN}Development environment launched!${NC}"
EOF

# Make the script executable
chmod +x ~/Developer/setup-scripts/launch_dev_env.sh

# Create an alias in .zshrc
echo 'alias devstart="~/Developer/setup-scripts/launch_dev_env.sh"' >> ~/.zshrc
```

## Conclusion

You now have a comprehensive development environment setup for Python and web development. Here's a summary of what you've configured:

1. **Core Development Tools**
   - Python with pyenv for version management
   - Poetry for dependency management
   - Node.js and Yarn for web development
   - Various command-line utilities

2. **Python Environment**
   - Project-specific virtual environments
   - Code formatting and linting
   - Testing framework

3. **VS Code Configuration**
   - Extensions for Python and web development
   - Custom settings for optimal workflow
   - Code snippets and shortcuts

4. **Project Templates**
   - Scripts to create new Python and web projects
   - GitHub templates for issues and pull requests
   - GitHub Actions workflows

5. **Workflow Guides**
   - Python development workflow
   - Web development workflow
   - VS Code customization

## Getting Started

To start working on a new Python project:

```bash
# Create a new Python project
newpy my-project "My awesome Python project"

# Navigate to the project
cd ~/Developer/my-project

# Create a GitHub repository
gh repo create my-project --public --source=.

# Open VS Code
code .
```

To start working on a new web project:

```bash
# Create a new web project
newweb my-website "My awesome website"

# Navigate to the project
cd ~/Developer/my-website

# Create a GitHub repository
gh repo create my-website --public --source=.

# Open VS Code
code .
```

To launch your development environment:

```bash
devstart
```

Happy coding!