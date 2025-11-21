# Development Environment Setup Guide

Complete guide to using and configuring your development environment after Phase 3 installation.

## Table of Contents

1. [Python Development](#python-development)
2. [Docker & Containers](#docker--containers)
3. [Local LLM with Ollama](#local-llm-with-ollama)
4. [VS Code Configuration](#vs-code-configuration)
5. [Project Templates](#project-templates)
6. [Development Workflows](#development-workflows)

**For detailed development workflows, local development, and container-based development, see [DEVELOPMENT-WORKFLOWS.md](./DEVELOPMENT-WORKFLOWS.md)**

---

## 🐍 Python Development

### Available Python Tools

After Phase 3 installation, you have:
- **Python 3.11+** (via Homebrew)
- **pip** - Package manager
- **venv** - Virtual environments (built-in)
- **Essential packages** - numpy, pandas, matplotlib, scikit-learn, jupyter, torch, tensorflow
- **AI packages** - anthropic, openai (for API access)

### Creating and Using Virtual Environments

**Best Practice:** Always use a virtual environment for each project.

#### Method 1: Using Built-in venv

```bash
# Create a new virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate

# You'll see (venv) in your prompt

# Install packages
pip install requests pandas

# Check installed packages
pip list

# Deactivate when done
deactivate
```

#### Method 2: Quick Project Setup

```bash
# Navigate to standard project directory
cd ~/Developer/MyProject

# Create and activate environment in one go
python3 -m venv venv && source venv/bin/activate

# Install requirements
pip install -r requirements.txt

# Start developing
python3 src/main.py
```

### Managing Python Packages

```bash
# Install a package
pip install numpy

# Install specific version
pip install numpy==1.24.0

# Install from requirements file
pip install -r requirements.txt

# Upgrade a package
pip install --upgrade numpy

# List installed packages
pip list

# Export current environment
pip freeze > requirements.txt

# Remove a package
pip uninstall numpy
```

### Common Development Tasks

#### Running Python Scripts

```bash
# Make sure environment is activated first
source venv/bin/activate

# Run a script
python3 script.py

# Run with specific Python version
python3.11 script.py

# Run Python interactively
python3
>>> import numpy as np
>>> np.array([1, 2, 3])
>>> exit()
```

#### Using Jupyter Notebooks

```bash
# Install Jupyter (if not already)
pip install jupyter

# Start Jupyter server
jupyter notebook

# Opens browser at http://localhost:8888
# Create new notebook and start developing

# To stop: Ctrl+C in terminal
```

#### Creating Requirements File

```bash
# After you install packages in your project:
pip freeze > requirements.txt

# Another developer can then install all:
pip install -r requirements.txt

# Good practice: exclude development packages
pip freeze | grep -v -i "jupyter\|pytest\|flake8" > requirements.txt
```

### Installed Python Packages

After Phase 3, you have these pre-installed:

| Package | Purpose |
|---------|---------|
| numpy | Numerical computing |
| pandas | Data manipulation |
| matplotlib | Plotting and visualization |
| seaborn | Statistical data visualization |
| scikit-learn | Machine learning |
| jupyter | Interactive notebooks |
| torch | PyTorch (deep learning) |
| tensorflow | TensorFlow (deep learning) |
| transformers | HuggingFace models |
| nltk | Natural language processing |
| spacy | Advanced NLP |
| gensim | Topic modeling |
| anthropic | Anthropic API (Claude) |
| openai | OpenAI API (ChatGPT) |
| python-dotenv | Environment variable management |
| requests | HTTP client |

### Example: Data Science Project

```bash
# Create project in standard location
mkdir -p ~/Developer/MyProject
cd ~/Developer/MyProject

# Create environment
python3 -m venv venv
source venv/bin/activate

# Create requirements
cat > requirements.txt << EOF
numpy==1.24.0
pandas==2.0.0
matplotlib==3.7.0
jupyter==1.0.0
scikit-learn==1.3.0
EOF

# Install
pip install -r requirements.txt

# Create notebook
jupyter notebook

# In notebook:
# - Import pandas: import pandas as pd
# - Load data: df = pd.read_csv('data.csv')
# - Analyze and visualize
```

---

## 🐳 Docker & Containers

### Docker Basics

After Phase 3, you have:
- **Docker Desktop** - Container runtime for macOS
- **Docker CLI** - Command-line tools
- **Docker Compose** - Multi-container orchestration

### Checking Docker Status

```bash
# Check if Docker is running
docker ps

# If you get "Cannot connect to Docker daemon":
# 1. Open Docker.app from Applications
# 2. Wait for it to fully start (icon in top menu bar)
# 3. Try again

# Check Docker version
docker --version

# Check Docker Compose
docker compose --version
```

### Basic Docker Commands

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# List Docker images
docker images

# Run a container
docker run -it ubuntu bash

# Pull an image
docker pull python:3.11

# Run a Python container
docker run -it python:3.11 python3

# Run container in background
docker run -d -p 8080:8080 image_name

# Stop a container
docker stop container_id

# Remove a container
docker rm container_id

# Remove an image
docker rmi image_id
```

### Creating a Docker Image

Create a `Dockerfile`:

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["python3", "main.py"]
```

Build and run:

```bash
# Build image
docker build -t my_app .

# Run container
docker run my_app

# Run with volume mount (for development)
docker run -v $(pwd):/app my_app
```

### Docker Compose for Multi-Container Apps

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: password
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

Run with Compose:

```bash
# Start all services
docker compose up

# Run in background
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs -f
```

### Useful Docker Patterns

#### Development with Hot Reload

```bash
# Mount current directory into container
docker run -it -v $(pwd):/app python:3.11 bash

# Changes on your Mac are immediately visible in container
```

#### Database Container

```bash
# PostgreSQL
docker run -d \
  --name postgres \
  -e POSTGRES_PASSWORD=password \
  -p 5432:5432 \
  postgres:15

# MongoDB
docker run -d \
  --name mongodb \
  -p 27017:27017 \
  mongo:latest
```

#### Jupyter in Docker

```bash
docker run -d \
  -p 8888:8888 \
  -v $(pwd):/workspace \
  jupyter/datascience-notebook:latest

# Get token
docker logs container_id | grep token

# Open in browser: http://localhost:8888
```

### Docker Cleanup

```bash
# Remove stopped containers
docker container prune

# Remove unused images
docker image prune -a

# Remove unused volumes
docker volume prune

# See what's using space
docker system df
```

---

## 🤖 Local LLM with Ollama

### Ollama Basics

After Phase 3, you have **Ollama** installed - a tool to run LLMs locally without GPU requirements (though GPU helps).

### Starting Ollama

```bash
# Start Ollama server (runs in background)
ollama serve

# Or run in background
ollama serve &

# In another terminal, you can now use ollama commands
```

### Downloading Models

```bash
# List available models
ollama list

# Download a lightweight model (2.7 GB)
ollama pull mistral

# Download a medium model (7 GB)
ollama pull llama2

# Download a large model (13 GB+)
ollama pull neural-chat

# Show model details
ollama show mistral
```

Available models: https://ollama.ai/library

| Model | Size | Speed | Memory |
|-------|------|-------|--------|
| mistral | 4.1GB | Fast | Good |
| llama2 | 3.8GB | Medium | Good |
| neural-chat | 4.7GB | Fast | Good |
| dolphin-mixtral | 26GB | Slow | High |
| orca2 | 3.5GB | Fast | Good |

### Using Ollama Models

#### Terminal Chat

```bash
# Start chatting with a model
ollama run mistral

# Type your prompt
> What is machine learning?

# Model responds
# Type 'exit' or press Ctrl+D to quit
```

#### Using Ollama with Python

```python
import requests
import json

# Make sure ollama serve is running
response = requests.post(
    'http://localhost:11434/api/generate',
    json={
        'model': 'mistral',
        'prompt': 'Explain machine learning in 100 words',
        'stream': False
    }
)

result = json.loads(response.text)
print(result['response'])
```

#### Using with Anthropic/OpenAI Compatible Interface

```python
# Some Ollama models support OpenAI-compatible API
# When using Open WebUI or certain tools

import requests

response = requests.post(
    'http://localhost:11434/v1/chat/completions',
    json={
        'model': 'mistral',
        'messages': [
            {'role': 'user', 'content': 'Hello!'}
        ]
    }
)

print(response.json())
```

### Open WebUI - Web Interface for Ollama

Access your local LLM through a web interface:

```bash
# Make sure Ollama is running
ollama serve &

# Start Open WebUI
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  ghcr.io/open-webui/open-webui:latest

# Open browser: http://localhost:3000

# Create account and select your model from dropdown
```

### Ollama Model Files

Create custom models with `Modelfile`:

```modelfile
FROM mistral

# Set parameters
PARAMETER temperature 0.7
PARAMETER num_predict 256

# System prompt
SYSTEM """
You are a helpful coding assistant. Respond only with code when asked.
"""
```

Build and use:

```bash
# Create the Modelfile
nano Modelfile  # paste content above

# Build custom model
ollama create my-coder -f Modelfile

# Use it
ollama run my-coder "Write a Python function to reverse a string"
```

### Advanced Ollama Usage

#### Batch Processing

```python
import subprocess
import json

prompts = [
    "What is AI?",
    "Explain ML in one sentence",
    "Define deep learning"
]

for prompt in prompts:
    result = subprocess.run(
        ['ollama', 'run', 'mistral', prompt],
        capture_output=True,
        text=True
    )
    print(f"Q: {prompt}")
    print(f"A: {result.stdout}\n")
```

#### Integration with Your App

```python
# Use in your Python app
import requests

def query_local_llm(prompt, model='mistral'):
    response = requests.post(
        'http://localhost:11434/api/generate',
        json={
            'model': model,
            'prompt': prompt,
            'stream': False,
            'temperature': 0.7
        }
    )
    return response.json()['response']

# Use it
result = query_local_llm("Summarize: The quick brown fox...")
print(result)
```

### Managing Ollama Models

```bash
# List downloaded models
ollama list

# Show model information
ollama show mistral

# Remove a model (to free space)
ollama rm llama2

# Pull a specific version
ollama pull mistral:7b

# Update a model
ollama pull mistral  # Re-downloads if newer version exists
```

---

## 💻 VS Code Configuration

### Python Development in VS Code

#### Install Extensions

1. Open VS Code
2. Click Extensions (Ctrl+Shift+X)
3. Install:
   - **Python** (Microsoft)
   - **Pylance** (Microsoft)
   - **Jupyter** (Microsoft)
   - **Black Formatter** (Microsoft)
   - **Pylint** (Microsoft)
   - **Claude Code** (Anthropic) - AI-powered coding assistant for development workflows

#### Configure Python Interpreter

```
Cmd+Shift+P → Python: Select Interpreter

Choose your virtual environment:
./venv/bin/python (if in project with venv)
```

#### Create Workspace Settings

In your project root, create `.vscode/settings.json`:

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
  "python.testing.pytestArgs": ["tests"]
}
```

### Docker in VS Code

Install **Docker** extension (Microsoft).

Then you can:
- View Docker images and containers
- Build images from Dockerfile
- Run containers with interactive terminal
- View container logs
- Push to registries

### Jupyter Notebooks in VS Code

1. Create a `.ipynb` file
2. VS Code opens Jupyter interface
3. Select Python kernel (your venv)
4. Start coding in cells
5. Execute with Shift+Enter

### Debugging Python in VS Code

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Current File",
      "type": "python",
      "request": "launch",
      "program": "${file}",
      "console": "integratedTerminal",
      "justMyCode": true
    }
  ]
}
```

Use: F5 to debug or Ctrl+F5 to run.

### Terminal in VS Code

VS Code automatically uses your default shell (zsh with Oh My Zsh theme).

Open terminal: Ctrl+`

---

## 📦 Project Templates

> **📖 See [DEVELOPMENT-WORKFLOWS.md](./DEVELOPMENT-WORKFLOWS.md) for comprehensive project setup guides using the standard `~/Developer/MyProject` location.**

### Python Web App (Flask)

```bash
cd ~/Developer
mkdir MyProject && cd MyProject
python3 -m venv venv
source venv/bin/activate

pip install flask

mkdir src
cat > src/app.py << 'EOF'
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(debug=True)
EOF

python3 src/app.py
# Open: http://localhost:5000
```

### Data Science Project

```bash
cd ~/Developer
mkdir MyProject && cd MyProject
python3 -m venv venv
source venv/bin/activate

pip install pandas numpy matplotlib jupyter scikit-learn

# Start Jupyter
jupyter notebook

# In notebook:
# - Load data with pandas
# - Explore with numpy
# - Visualize with matplotlib
# - Build ML model with scikit-learn
```

### Docker App

```bash
cd ~/Developer
mkdir MyProject && cd MyProject

cat > Dockerfile << 'EOF'
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python3", "main.py"]
EOF

cat > requirements.txt << 'EOF'
requests
EOF

cat > main.py << 'EOF'
import requests
response = requests.get('https://api.github.com')
print(f"GitHub API Status: {response.status_code}")
EOF

docker build -t my_app .
docker run my_app
```

### AI/LLM Project

```bash
cd ~/Developer
mkdir MyProject && cd MyProject
python3 -m venv venv
source venv/bin/activate

pip install anthropic python-dotenv

cat > .env << 'EOF'
ANTHROPIC_API_KEY=your_key_here
EOF

mkdir src
cat > src/main.py << 'EOF'
import os
from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()
client = Anthropic()

message = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    max_tokens=1024,
    messages=[
        {"role": "user", "content": "What is machine learning?"}
    ]
)

print(message.content[0].text)
EOF

python3 src/main.py
```

---

## 🔄 Development Workflows

> **📖 For comprehensive development workflows including local development, container-based development, and detailed step-by-step guides, please see [DEVELOPMENT-WORKFLOWS.md](./DEVELOPMENT-WORKFLOWS.md)**

This section provides quick reference summaries. The dedicated workflows guide includes:

- **Standard project location**: `~/Developer/MyProject`
- **Local development workflow**: Complete setup and daily routines
- **Container-based development**: Docker and Docker Compose for development
- **Using Claude Code extension**: AI-powered coding assistance
- **Common development patterns**: Scripts, features, prototyping, CLIs, APIs
- **Debugging strategies**: Print debugging, interactive debugging, logging

### Quick Start Template

For a new project, see the complete workflow in [DEVELOPMENT-WORKFLOWS.md](./DEVELOPMENT-WORKFLOWS.md#initial-project-setup).

Quick reference:

```bash
# Create project in standard location
cd ~/Developer
mkdir MyProject
cd MyProject

# Initialize
git init
python3 -m venv venv
source venv/bin/activate

# Start coding
code .
```

### VS Code Debugging

Use F5 to start debugging after setting breakpoints. For detailed debugging strategies, see [DEVELOPMENT-WORKFLOWS.md - Debugging Strategies](./DEVELOPMENT-WORKFLOWS.md#-debugging-strategies).

```bash
# CLI debugging
python3 -m pdb src/main.py
(Pdb) l        # List code
(Pdb) n        # Next line
(Pdb) c        # Continue
```

---

## 📚 Learning Resources

### Python
- Official: https://python.org/docs
- Real Python: https://realpython.com
- Kaggle: https://kaggle.com/learn

### Docker
- Official: https://docs.docker.com
- Play with Docker: https://labs.play-with-docker.com

### Machine Learning
- Fast.ai: https://fast.ai
- TensorFlow: https://tensorflow.org/learn
- PyTorch: https://pytorch.org/tutorials

### Ollama & Local LLMs
- Ollama: https://ollama.ai
- Open WebUI: https://github.com/open-webui/open-webui
- Model Library: https://ollama.ai/library

---

**Happy developing!** You now have a complete development environment ready for any Python, data science, or AI project. 🚀
