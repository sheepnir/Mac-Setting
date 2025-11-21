# Development Workflows Guide

This guide provides standardized workflows for developing on your Mac, with examples for both local development and containerized development environments.

## Project Location Convention

**All development projects should be created in: `~/Developer/MyProject`**

This standardizes your development workspace and makes it easy to find projects.

## Table of Contents

1. [Local Development Workflow](#local-development-workflow)
2. [Container-Based Development](#container-based-development)
3. [Using Claude Code Extension](#using-claude-code-extension)
4. [Common Development Patterns](#common-development-patterns)
5. [Debugging Strategies](#debugging-strategies)

---

## 🏠 Local Development Workflow

### Initial Project Setup

Create a new project in the standard location:

```bash
# Navigate to developer directory
cd ~/Developer

# Create your project (replace MyProject with actual name)
mkdir MyProject
cd MyProject

# Initialize git repository
git init
git config user.name "Nir Sheep"
git config user.email "sheep.nir@gmail.com"

# Create Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Create project structure
mkdir src tests data

# Create essential files
touch src/main.py
touch requirements.txt
touch README.md
touch .gitignore

# Add gitignore content
cat > .gitignore << 'EOF'
venv/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
*.egg-info/
dist/
build/
.env
.venv
.DS_Store
.idea/
.vscode/settings.json
.pytest_cache/
.coverage
*.log
EOF

# Initial git commit
git add .
git commit -m "Initial project setup"

# Open in VS Code
code .
```

### Daily Development Routine

```bash
# Start development session
cd ~/Developer/MyProject
source venv/bin/activate

# Install/update dependencies (if requirements.txt changed)
pip install -r requirements.txt

# Pull latest changes (if working with remote)
git pull origin main

# Open project in VS Code
code .

# During development - run/test frequently
python3 src/main.py
pytest tests/

# When changes are ready
git add .
git commit -m "Feature: Add new functionality"
git push origin main

# End session
deactivate
```

### Development with Virtual Environments

```bash
# Create venv (one-time)
python3 -m venv venv

# Activate before each session
source venv/bin/activate

# You'll see (venv) in your prompt

# Install packages
pip install requests pandas numpy

# Check what's installed
pip list

# Create requirements file for sharing
pip freeze > requirements.txt

# Other developer can install everything
pip install -r requirements.txt

# Deactivate when done
deactivate
```

### Python Script Development

```bash
# Edit and test frequently
nano src/main.py

# Run script
python3 src/main.py

# Debug with print statements
# OR use VS Code debugger:
# - Set breakpoint (click line number)
# - Press F5
# - Step through with F10

# Run from VS Code terminal
Ctrl+`  # Open integrated terminal
python3 src/main.py
```

### Data Science Workflow

```bash
cd ~/Developer/MyProject
source venv/bin/activate

# Install data science packages
pip install pandas numpy matplotlib jupyter scikit-learn

# Create notebook
jupyter notebook

# In browser: http://localhost:8888
# - Create new Python notebook
# - Import libraries: import pandas as pd
# - Load and analyze data
# - Create visualizations
# - Save notebook

# Or run Jupyter from VS Code
# - Create .ipynb file
# - VS Code shows Jupyter interface
# - Select Python kernel (your venv)
# - Write and execute cells
```

### Web Application Development (Flask)

```bash
cd ~/Developer/MyProject
source venv/bin/activate

# Install Flask
pip install flask

# Create app structure
mkdir templates static

# Create app
cat > src/app.py << 'EOF'
from flask import Flask, render_template

app = Flask(__name__, template_folder='../templates', static_folder='../static')

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/data')
def get_data():
    return {'message': 'Hello from Flask'}

if __name__ == '__main__':
    app.run(debug=True, port=5000)
EOF

# Create HTML template
cat > templates/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>My App</title></head>
<body>
    <h1>Welcome to Flask</h1>
</body>
</html>
EOF

# Run development server
python3 src/app.py

# Open: http://localhost:5000
# Server auto-reloads on code changes with debug=True
```

---

## 🐳 Container-Based Development

### Why Develop in Containers?

- **Consistency**: Same environment as production
- **Isolation**: Project dependencies don't conflict
- **Reproducibility**: Other developers get exact same setup
- **Simplicity**: No need to install everything locally
- **Cleanup**: Delete container, everything's gone

### Basic Container Development

```bash
cd ~/Developer/MyProject

# Create Dockerfile for development
cat > Dockerfile.dev << 'EOF'
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies if needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy project code
COPY . .

# Run python interactively
CMD ["python3"]
EOF

# Build image
docker build -f Dockerfile.dev -t myproject-dev .

# Enter container with your code mounted
docker run -it -v $(pwd):/app myproject-dev bash

# Inside container:
# python3 src/main.py
# pip install new_package
# python3 -m pytest tests/
```

### Development with Docker Compose

For projects with multiple services (Python app + database):

```bash
cd ~/Developer/MyProject

# Create docker-compose.dev.yml
cat > docker-compose.dev.yml << 'EOF'
version: '3.8'

services:
  # Python application
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - .:/app
    ports:
      - "5000:5000"
    environment:
      - PYTHONUNBUFFERED=1
      - FLASK_ENV=development
    depends_on:
      - db
    command: python3 src/app.py

  # PostgreSQL database
  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: devpass
      POSTGRES_DB: myproject_db
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  postgres_data:
EOF

# Start all services
docker compose -f docker-compose.dev.yml up

# In another terminal, interact with app
curl http://localhost:5000

# Access database
docker exec -it myproject-db psql -U postgres -d myproject_db

# Stop everything
docker compose -f docker-compose.dev.yml down
```

### Edit Code, Run in Container

```bash
cd ~/Developer/MyProject

# Start container with code mounted
docker run -it -v $(pwd):/app python:3.11 bash

# Inside container:
cd /app
pip install -r requirements.txt
python3 src/main.py

# Edit on Mac side, changes visible immediately in container
# Exit container: exit or Ctrl+D
```

### Hot Reload Development

```bash
# Dockerfile for development with auto-reload
cat > Dockerfile.dev << 'EOF'
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt && pip install watchdog[watchmedo]

COPY . .

# Use watchdog for hot reload
CMD ["watchmedo", "shell-command", \
    "--patterns=*.py", \
    "--ignore-patterns=__pycache__", \
    "--recursive", \
    "--command=python3 src/main.py", \
    "."]
EOF

# Build and run
docker build -f Dockerfile.dev -t myproject-dev .
docker run -it -v $(pwd):/app myproject-dev

# Any .py file change automatically restarts the app
```

### Python Package Development in Container

```bash
cd ~/Developer/MyProject

# Dockerfile for package development
cat > Dockerfile.dev << 'EOF'
FROM python:3.11-slim

WORKDIR /app

# Install development tools
RUN pip install pytest pytest-cov black flake8 mypy

COPY . .

# Default to running tests
CMD ["pytest", "-v"]
EOF

# Build
docker build -f Dockerfile.dev -t myproject-dev .

# Run tests in container
docker run myproject-dev

# Run with specific pytest options
docker run myproject-dev pytest -v tests/test_specific.py

# Format code in container
docker run -v $(pwd):/app myproject-dev black src/

# Check types
docker run myproject-dev mypy src/
```

### Data Processing Pipeline in Container

```bash
cd ~/Developer/MyProject

cat > Dockerfile.dev << 'EOF'
FROM python:3.11-slim

WORKDIR /app

RUN pip install pandas numpy scikit-learn jupyter

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Start Jupyter in container
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
EOF

# Build and run
docker build -f Dockerfile.dev -t myproject-dev .
docker run -d \
  -p 8888:8888 \
  -v $(pwd):/app \
  --name myproject \
  myproject-dev

# Get Jupyter token
docker logs myproject | grep token

# Open: http://localhost:8888?token=...
```

### Debugging in Containers

```bash
cd ~/Developer/MyProject

# Dockerfile with debugging tools
cat > Dockerfile.dev << 'EOF'
FROM python:3.11-slim

WORKDIR /app

RUN pip install pdb ipdb

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Run with debugging enabled
CMD ["python3", "-m", "pdb", "src/main.py"]
EOF

# Build
docker build -f Dockerfile.dev -t myproject-dev .

# Run debugger
docker run -it myproject-dev
# (Pdb) commands: l(ist), n(ext), s(tep), c(ontinue), p(rint)
```

---

## 🤖 Using Claude Code Extension

Claude Code is an AI-powered assistant built into VS Code that helps with your development workflows.

### Installation

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Claude Code" by Anthropic
4. Click Install

### Basic Usage

#### Getting Help with Code

```python
# Type or select code in VS Code
def calculate_average(numbers):
    return sum(numbers) / len(numbers)

# Right-click → Claude Code → Ask Claude
# Ask: "Is this function safe? What if the list is empty?"
# Claude analyzes and suggests improvements
```

#### Generating Code

```
# Type a comment with your intention
# Generate a function that reverses a string and removes spaces

# Select the comment
# Right-click → Claude Code → Generate Code
# Claude writes the function implementation
```

#### Debugging Assistance

```python
# When you have a bug
def process_data(data):
    for item in data:
        result = item * 2
        print(result)

# Select function
# Right-click → Claude Code → Explain
# Claude explains what the function does and potential issues
```

#### Code Review

```
# Highlight a block of code
# Right-click → Claude Code → Review
# Claude provides feedback on:
# - Code quality and best practices
# - Performance improvements
# - Security issues
# - Readability suggestions
```

#### Documentation

```python
def complex_algorithm(x, y, z):
    return (x ** y) % z

# Select function
# Right-click → Claude Code → Document
# Claude generates docstring and explains the logic
```

### Common Workflows

#### Learning a New Library

```
# In Claude Code conversation:
# "I want to learn pandas. Can you show me how to:
#  1. Load a CSV file
#  2. Filter rows
#  3. Group by column
#  4. Calculate mean"
#
# Claude provides examples and explanations
```

#### Converting Code

```
# "Convert this JavaScript function to Python"
# [paste code]
# Claude converts with explanation
```

#### Optimizing Performance

```
# "This function is slow. How can I optimize it?"
# [paste code]
# Claude suggests vectorization, caching, algorithms
```

#### Writing Tests

```python
# Select a function
# Ask Claude: "Write comprehensive tests for this function"
# Claude generates pytest test suite
```

---

## 📋 Common Development Patterns

### Pattern 1: Quick Script Testing

```bash
cd ~/Developer/MyProject

# Create simple script
cat > test_idea.py << 'EOF'
# Quick test of an idea
def new_feature():
    pass

if __name__ == "__main__":
    new_feature()
EOF

# Test it
python3 test_idea.py

# If working, integrate into project
# If not, iterate

# Clean up when done
rm test_idea.py
```

### Pattern 2: Feature Branch Development

```bash
cd ~/Developer/MyProject

# Create feature branch
git checkout -b feature/new-feature

# Make changes, test
python3 -m pytest tests/

# Commit regularly
git add src/
git commit -m "Add new feature - part 1"

# When ready
git checkout main
git merge feature/new-feature
git push origin main

# Clean up
git branch -d feature/new-feature
```

### Pattern 3: Prototyping with Jupyter

```bash
cd ~/Developer/MyProject

# Create notebook for experimentation
jupyter notebook

# In notebook:
# 1. Experiment with code
# 2. Visualize data
# 3. Test ideas
# 4. When working, move to .py files

# Clean up experiment notebook
rm experiment.ipynb
```

### Pattern 4: Using CLI for Development

```bash
cd ~/Developer/MyProject
source venv/bin/activate

# Create CLI tool using Click
pip install click

cat > src/cli.py << 'EOF'
import click

@click.command()
@click.option('--name', default='World')
def hello(name):
    """Simple greeting CLI"""
    click.echo(f'Hello {name}!')

if __name__ == '__main__':
    hello()
EOF

# Test
python3 src/cli.py --name "Alice"

# Use with arguments
python3 src/cli.py --name "Developer"
```

### Pattern 5: API Development

```bash
cd ~/Developer/MyProject

# Create FastAPI application
pip install fastapi uvicorn

cat > src/api.py << 'EOF'
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello API"}

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
EOF

# Run
python3 src/api.py

# Test
curl http://localhost:8000/items/42
```

---

## 🐛 Debugging Strategies

### Strategy 1: Print Debugging

```python
def process_data(items):
    print(f"Input: {items}")

    result = []
    for item in items:
        processed = item * 2
        print(f"Processing {item} -> {processed}")
        result.append(processed)

    print(f"Output: {result}")
    return result

# Run and observe output
python3 src/main.py
```

### Strategy 2: Interactive Debugging in VS Code

```python
def buggy_function():
    x = 10
    y = 0
    # Set breakpoint by clicking line number
    z = x / y  # Breakpoint here
    return z

# Press F5 to debug
# Step through with F10
# Check variables in Debug panel
# Continue with F5
```

### Strategy 3: Command-Line Debugging

```bash
cd ~/Developer/MyProject
source venv/bin/activate

# Run with Python debugger
python3 -m pdb src/main.py

# Debugger commands:
# l - List code
# n - Next line
# s - Step into function
# c - Continue execution
# p variable - Print variable
# h - Help
```

### Strategy 4: Container Debugging

```bash
cd ~/Developer/MyProject

# Run container with debugging
docker run -it -v $(pwd):/app python:3.11 bash

# Inside container, use same debugging tools
cd /app
python3 -m pdb src/main.py
```

### Strategy 5: Logging for Production-Like Debugging

```python
import logging

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('debug.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

def process_data(items):
    logger.info(f"Processing {len(items)} items")

    for item in items:
        logger.debug(f"Item: {item}")
        if item < 0:
            logger.warning(f"Negative item detected: {item}")

    logger.info("Processing complete")

# Run and check debug.log
python3 src/main.py
cat debug.log
```

---

## 🔍 VS Code Tips for Development

### Keyboard Shortcuts

```
Ctrl+`        - Toggle integrated terminal
Ctrl+Shift+P  - Command palette
Ctrl+/        - Toggle comment
Ctrl+D        - Select next occurrence
Ctrl+Shift+L  - Select all occurrences
F5            - Start/continue debugging
F10           - Step over
F11           - Step into
Shift+F5      - Stop debugging
Ctrl+Shift+F  - Find across project
```

### Workspace Configuration

Create `.vscode/settings.json` in your project:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/venv/bin/python",
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "python.formatting.provider": "black",
  "[python]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-python.python",
    "editor.insertSpaces": true,
    "editor.tabSize": 4
  },
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": ["tests"],
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true,
    ".git": true
  }
}
```

---

## 📚 Quick Reference

### Project Setup (One-Time)

```bash
cd ~/Developer
mkdir MyProject
cd MyProject
git init
python3 -m venv venv
source venv/bin/activate
touch requirements.txt
code .
```

### Daily Start

```bash
cd ~/Developer/MyProject
source venv/bin/activate
code .
```

### Common Commands

```bash
# Activate venv
source venv/bin/activate

# Install packages
pip install package_name

# Save dependencies
pip freeze > requirements.txt

# Run script
python3 src/main.py

# Run tests
pytest

# Format code
black src/

# Check types
mypy src/

# Git commands
git add .
git commit -m "message"
git push origin main
```

---

**Happy developing!** Follow these workflows to maintain consistency across all your projects. 🚀
