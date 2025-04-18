# MacBook Pro M3 Max (14") Development Environment Setup

This guide provides step-by-step instructions for setting up a development environment on your MacBook Pro M3 Max, focusing on Docker and Python development in containers.

## Prerequisites

Ensure you've completed the basic setup steps from the first part of this guide (Steps 1-12).

## Step 1: Install Docker Desktop for Mac

1. Install Docker Desktop using Homebrew:
   ```
   brew install --cask docker
   ```

2. Launch Docker Desktop from your Applications folder.

3. Follow the on-screen instructions to complete the installation and configuration.

4. Verify Docker installation in Terminal:
   ```
   docker --version
   docker compose version
   ```

5. Create a script to optimize Docker for M3 Max:
   ```
   cd ~/Developer/setup-scripts
   nano docker_optimize.sh
   ```

6. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create Docker configuration directory if it doesn't exist
   mkdir -p ~/.docker
   
   # Configure Docker Desktop for M3 Max performance
   cat > ~/.docker/daemon.json << EOF
   {
     "experimental": true,
     "builder": {
       "gc": {
         "enabled": true,
         "defaultKeepStorage": "20GB"
       }
     },
     "features": {
       "buildkit": true
     },
     "resources": {
       "memory": 16.0,
       "cpu": 10
     }
   }
   EOF
   
   echo "Docker has been optimized for M3 Max. Please restart Docker Desktop."
   ```

7. Make the script executable and run it:
   ```
   chmod +x docker_optimize.sh
   ./docker_optimize.sh
   ```

8. Restart Docker Desktop to apply the changes.

## Step 2: Set Up Python Development Environment with Docker

1. Create a Docker Python development script:
   ```
   cd ~/Developer/setup-scripts
   nano setup_python_docker.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create a Python development directory
   mkdir -p ~/Developer/python-projects
   
   # Create a template Dockerfile for Python development
   cat > ~/Developer/python-projects/Dockerfile.template << EOF
   FROM python:3.12-slim
   
   WORKDIR /app
   
   # Install system dependencies
   RUN apt-get update && apt-get install -y \\
       build-essential \\
       curl \\
       git \\
       && rm -rf /var/lib/apt/lists/*
   
   # Install Python dependencies
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt
   
   # Copy source code
   COPY . .
   
   # Command to run when container starts
   CMD ["python", "app.py"]
   EOF
   
   # Create a template docker-compose.yml file
   cat > ~/Developer/python-projects/docker-compose.template.yml << EOF
   version: '3.8'
   
   services:
     app:
       build: .
       volumes:
         - .:/app
       ports:
         - "8000:8000"
       environment:
         - PYTHONUNBUFFERED=1
       command: python app.py
   EOF
   
   # Create a template requirements.txt file
   cat > ~/Developer/python-projects/requirements.template.txt << EOF
   # Data analysis & machine learning
   numpy
   pandas
   scikit-learn
   matplotlib
   seaborn
   jupyter
   
   # Web development
   fastapi
   uvicorn
   
   # API clients
   requests
   anthropic
   openai
   
   # Development tools
   pytest
   black
   isort
   mypy
   python-dotenv
   EOF
   
   # Create a script to initialize a new Python Docker project
   cat > ~/Developer/python-projects/init_project.sh << EOF
   #!/bin/bash
   
   if [ -z "\$1" ]; then
     echo "Please provide a project name"
     echo "Usage: ./init_project.sh <project_name>"
     exit 1
   fi
   
   PROJECT_NAME="\$1"
   mkdir -p "\$PROJECT_NAME"
   cd "\$PROJECT_NAME"
   
   cp ../Dockerfile.template Dockerfile
   cp ../docker-compose.template.yml docker-compose.yml
   cp ../requirements.template.txt requirements.txt
   
   # Create app.py file
   cat > app.py << EOL
   def main():
       print("Hello from \$PROJECT_NAME!")
       
   if __name__ == "__main__":
       main()
   EOL
   
   # Create a README.md file
   cat > README.md << EOL
   # \$PROJECT_NAME
   
   Python project running in Docker.
   
   ## Setup
   
   1. Build the Docker image:
      \`\`\`
      docker-compose build
      \`\`\`
      
   2. Run the container:
      \`\`\`
      docker-compose up
      \`\`\`
      
   3. For interactive shell:
      \`\`\`
      docker-compose run app bash
      \`\`\`
   EOL
   
   echo "\$PROJECT_NAME has been initialized. Go to \$PROJECT_NAME directory to start developing."
   EOF
   
   # Make the init script executable
   chmod +x ~/Developer/python-projects/init_project.sh
   
   echo "Python Docker development environment has been set up."
   echo "Use ~/Developer/python-projects/init_project.sh <project_name> to create a new project."
   ```

3. Make the script executable and run it:
   ```
   chmod +x setup_python_docker.sh
   ./setup_python_docker.sh
   ```

## Step 3: Install VS Code Extensions for Docker and Python Development

1. Create a script to install VS Code extensions:
   ```
   cd ~/Developer/setup-scripts
   nano install_vscode_extensions.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Install VS Code extensions for Docker and Python
   code --install-extension ms-python.python
   code --install-extension ms-azuretools.vscode-docker
   code --install-extension ms-vscode-remote.remote-containers
   code --install-extension ms-vscode.vscode-typescript-next
   code --install-extension ms-python.vscode-pylance
   code --install-extension ms-toolsai.jupyter
   code --install-extension matangover.mypy
   code --install-extension ms-python.black-formatter
   
   echo "VS Code extensions have been installed successfully!"
   ```

3. Make the script executable and run it:
   ```
   chmod +x install_vscode_extensions.sh
   ./install_vscode_extensions.sh
   ```

## Step 4: Configure VS Code for Docker and Python Development

1. Create a script to configure VS Code settings:
   ```
   cd ~/Developer/setup-scripts
   nano configure_vscode.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create VS Code settings directory if it doesn't exist
   mkdir -p ~/Library/Application\ Support/Code/User
   
   # Configure VS Code settings for Docker and Python
   cat > ~/Library/Application\ Support/Code/User/settings.json << EOF
   {
     "editor.formatOnSave": true,
     "editor.rulers": [88],
     "files.trimTrailingWhitespace": true,
     "files.insertFinalNewline": true,
     "files.trimFinalNewlines": true,
     
     "python.formatting.provider": "black",
     "python.linting.enabled": true,
     "python.linting.mypyEnabled": true,
     "python.linting.pylintEnabled": true,
     
     "docker.showStartPage": false,
     
     "[python]": {
       "editor.defaultFormatter": "ms-python.black-formatter",
       "editor.formatOnSave": true,
       "editor.codeActionsOnSave": {
         "source.organizeImports": true
       }
     },
     
     "python.terminal.activateEnvironment": true,
     "terminal.integrated.defaultProfile.osx": "zsh",
     "terminal.integrated.fontFamily": "MesloLGS NF"
   }
   EOF
   
   echo "VS Code has been configured for Docker and Python development."
   ```

3. Make the script executable and run it:
   ```
   chmod +x configure_vscode.sh
   ./configure_vscode.sh
   ```

## Step 5: Create Docker Compose Development Templates

1. Create a directory for Docker Compose templates:
   ```
   mkdir -p ~/Developer/docker-templates
   ```

2. Create a script to generate templates:
   ```
   cd ~/Developer/setup-scripts
   nano create_docker_templates.sh
   ```

3. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create directory for templates if it doesn't exist
   mkdir -p ~/Developer/docker-templates
   
   # Create a template for Python FastAPI development
   cat > ~/Developer/docker-templates/fastapi-template.yml << EOF
   version: '3.8'
   
   services:
     api:
       build: .
       volumes:
         - .:/app
       ports:
         - "8000:8000"
       environment:
         - PYTHONUNBUFFERED=1
       command: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
       depends_on:
         - db
     
     db:
       image: postgres:14
       volumes:
         - postgres_data:/var/lib/postgresql/data
       environment:
         - POSTGRES_USER=postgres
         - POSTGRES_PASSWORD=postgres
         - POSTGRES_DB=app
       ports:
         - "5432:5432"
   
   volumes:
     postgres_data:
   EOF
   
   # Create a template for data science projects
   cat > ~/Developer/docker-templates/datascience-template.yml << EOF
   version: '3.8'
   
   services:
     notebook:
       build: .
       volumes:
         - .:/app
       ports:
         - "8888:8888"
       environment:
         - PYTHONUNBUFFERED=1
       command: jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
   EOF
   
   # Create a template for multi-container development
   cat > ~/Developer/docker-templates/multi-service-template.yml << EOF
   version: '3.8'
   
   services:
     app:
       build: ./app
       volumes:
         - ./app:/app
       ports:
         - "8000:8000"
       environment:
         - PYTHONUNBUFFERED=1
       depends_on:
         - db
         - redis
     
     db:
       image: postgres:14
       volumes:
         - postgres_data:/var/lib/postgresql/data
       environment:
         - POSTGRES_USER=postgres
         - POSTGRES_PASSWORD=postgres
         - POSTGRES_DB=app
       ports:
         - "5432:5432"
     
     redis:
       image: redis:7
       ports:
         - "6379:6379"
   
   volumes:
     postgres_data:
   EOF
   
   echo "Docker Compose templates have been created in ~/Developer/docker-templates"
   ```

4. Make the script executable and run it:
   ```
   chmod +x create_docker_templates.sh
   ./create_docker_templates.sh
   ```

## Step 6: Set Up Docker Image Cleanup Script

1. Create a script to periodically clean up unused Docker images:
   ```
   cd ~/Developer/setup-scripts
   nano docker_cleanup.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Clean up Docker system
   echo "Cleaning up unused Docker resources..."
   
   # Remove all stopped containers
   docker container prune -f
   
   # Remove unused images
   docker image prune -a -f
   
   # Remove unused volumes
   docker volume prune -f
   
   # Remove unused networks
   docker network prune -f
   
   # Display Docker disk usage
   docker system df
   
   echo "Docker cleanup complete!"
   ```

3. Make the script executable:
   ```
   chmod +x docker_cleanup.sh
   ```

4. Set up a periodic cleanup using crontab:
   ```
   (crontab -l 2>/dev/null; echo "0 0 * * 0 ~/Developer/setup-scripts/docker_cleanup.sh >> ~/docker_cleanup.log 2>&1") | crontab -
   ```

## Step 7: Configure Shell Aliases for Docker and Python Development

1. Create a script to add useful Docker and Python aliases to your shell:
   ```
   cd ~/Developer/setup-scripts
   nano docker_aliases.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Add Docker and Python development aliases to .zshrc
   cat >> ~/.zshrc << EOF
   
   # Docker aliases
   alias dps="docker ps"
   alias dimg="docker images"
   alias dstop="docker stop \$(docker ps -q)"
   alias dclean="~/Developer/setup-scripts/docker_cleanup.sh"
   alias dcomp="docker-compose"
   alias dcup="docker-compose up"
   alias dcdown="docker-compose down"
   alias dcbuild="docker-compose build"
   alias dcrestart="docker-compose restart"
   alias dcexec="docker-compose exec"
   
   # Python Docker development aliases
   alias pyinit="~/Developer/python-projects/init_project.sh"
   alias pybuild="docker-compose build"
   alias pyrun="docker-compose up"
   alias pyshell="docker-compose run app bash"
   alias pytest="docker-compose run app pytest"
   
   # Helper functions
   dexec() {
     docker exec -it \$1 bash
   }
   
   pynew() {
     cd ~/Developer/python-projects && ./init_project.sh \$1 && cd \$1
   }
   EOF
   
   # Source the updated .zshrc file
   source ~/.zshrc
   
   echo "Docker and Python development aliases have been added to .zshrc"
   ```

3. Make the script executable and run it:
   ```
   chmod +x docker_aliases.sh
   ./docker_aliases.sh
   ```

## Step 8: Create Python Docker Project Templates

1. Create a directory for specialized Docker templates:
   ```
   mkdir -p ~/Developer/docker-templates/python
   ```

2. Create a data science template:
   ```
   cd ~/Developer/docker-templates/python
   nano Dockerfile.datascience
   ```

3. Add the following content:
   ```dockerfile
   FROM python:3.12-slim
   
   WORKDIR /app
   
   # Install system dependencies
   RUN apt-get update && apt-get install -y \
       build-essential \
       curl \
       git \
       wget \
       && rm -rf /var/lib/apt/lists/*
   
   # Install Python data science packages
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt
   
   # Set up Jupyter configuration
   RUN mkdir -p ~/.jupyter && \
       echo "c.NotebookApp.token = ''" >> ~/.jupyter/jupyter_notebook_config.py && \
       echo "c.NotebookApp.password = ''" >> ~/.jupyter/jupyter_notebook_config.py && \
       echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py
   
   # Copy source code
   COPY . .
   
   # Expose Jupyter port
   EXPOSE 8888
   
   # Command to run when container starts
   CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
   ```

4. Create a requirements file for data science:
   ```
   nano requirements.datascience.txt
   ```

5. Add the following content:
   ```
   # Data analysis & machine learning
   numpy
   pandas
   matplotlib
   seaborn
   scikit-learn
   scipy
   statsmodels
   
   # Deep learning
   tensorflow
   torch
   torchvision
   transformers
   
   # Jupyter
   jupyter
   jupyterlab
   ipywidgets
   
   # API clients
   requests
   anthropic
   openai
   
   # Utilities
   python-dotenv
   tqdm
   ```

6. Create a web API template:
   ```
   nano Dockerfile.webapi
   ```

7. Add the following content:
   ```dockerfile
   FROM python:3.12-slim
   
   WORKDIR /app
   
   # Install system dependencies
   RUN apt-get update && apt-get install -y \
       build-essential \
       curl \
       git \
       && rm -rf /var/lib/apt/lists/*
   
   # Install Python web packages
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt
   
   # Copy source code
   COPY . .
   
   # Expose API port
   EXPOSE 8000
   
   # Command to run when container starts
   CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
   ```

8. Create a requirements file for web API:
   ```
   nano requirements.webapi.txt
   ```

9. Add the following content:
   ```
   # Web frameworks
   fastapi
   uvicorn
   pydantic
   
   # Database
   sqlalchemy
   alembic
   psycopg2-binary
   
   # Authentication
   python-jose
   passlib
   bcrypt
   
   # Utilities
   python-multipart
   python-dotenv
   
   # API clients
   requests
   httpx
   anthropic
   openai
   
   # Testing
   pytest
   pytest-cov
   ```

10. Create a template script to initialize projects:
    ```
    nano create_python_project.sh
    ```

11. Add the following content:
    ```bash
    #!/bin/bash
    
    # Check if arguments are provided
    if [ $# -lt 2 ]; then
      echo "Usage: $0 <project_name> <template_type>"
      echo "Template types: datascience, webapi"
      exit 1
    fi
    
    PROJECT_NAME="$1"
    TEMPLATE_TYPE="$2"
    PROJECT_DIR=~/Developer/python-projects/$PROJECT_NAME
    
    # Check if template type is valid
    if [ "$TEMPLATE_TYPE" != "datascience" ] && [ "$TEMPLATE_TYPE" != "webapi" ]; then
      echo "Invalid template type. Use datascience or webapi."
      exit 1
    fi
    
    # Create project directory
    mkdir -p $PROJECT_DIR
    cd $PROJECT_DIR
    
    # Copy template files
    cp ~/Developer/docker-templates/python/Dockerfile.$TEMPLATE_TYPE ./Dockerfile
    cp ~/Developer/docker-templates/python/requirements.$TEMPLATE_TYPE.txt ./requirements.txt
    
    # Create docker-compose.yml based on template type
    if [ "$TEMPLATE_TYPE" = "datascience" ]; then
      cat > docker-compose.yml << EOF
    version: '3.8'
    
    services:
      notebook:
        build: .
        volumes:
          - .:/app
        ports:
          - "8888:8888"
        environment:
          - PYTHONUNBUFFERED=1
    EOF
    elif [ "$TEMPLATE_TYPE" = "webapi" ]; then
      cat > docker-compose.yml << EOF
    version: '3.8'
    
    services:
      api:
        build: .
        volumes:
          - .:/app
        ports:
          - "8000:8000"
        environment:
          - PYTHONUNBUFFERED=1
        depends_on:
          - db
      
      db:
        image: postgres:14
        volumes:
          - postgres_data:/var/lib/postgresql/data
        environment:
          - POSTGRES_USER=postgres
          - POSTGRES_PASSWORD=postgres
          - POSTGRES_DB=$PROJECT_NAME
        ports:
          - "5432:5432"
    
    volumes:
      postgres_data:
    EOF
    fi
    
    # Create project structure based on template type
    if [ "$TEMPLATE_TYPE" = "datascience" ]; then
      mkdir -p notebooks
      mkdir -p data
      mkdir -p scripts
      
      # Create example notebook
      cat > notebooks/example.ipynb << EOF
    {
     "cells": [
      {
       "cell_type": "markdown",
       "metadata": {},
       "source": [
        "# $PROJECT_NAME\n",
        "\n",
        "Example analysis notebook."
       ]
      },
      {
       "cell_type": "code",
       "execution_count": null,
       "metadata": {},
       "source": [
        "import numpy as np\n",
        "import pandas as pd\n",
        "import matplotlib.pyplot as plt\n",
        "import seaborn as sns\n",
        "\