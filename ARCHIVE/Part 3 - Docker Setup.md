# MacBook - Docker and Container Development Setup

This guide covers installing Docker Desktop on your MacBook Pro M3 Max and setting up an environment for Python development in containers.

## Step 1: Install Docker Desktop for Mac

1. Install Docker Desktop using Homebrew:
   ```bash
   brew install --cask docker
   ```

2. Launch Docker Desktop from your Applications folder.

3. Follow the on-screen instructions to complete the installation and configuration.

4. Verify Docker installation in Terminal:
   ```bash
   docker --version
   docker compose version
   ```

## Step 2: Optimize Docker for M3 Max

1. Create a script to optimize Docker for M3 Max:
   ```bash
   cd ~/Developer/setup-scripts
   nano docker_optimize.sh
   ```

2. Add the following content:
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
     }
   }
   EOF
   
   # Enable Rosetta for improved compatibility with x86 images
   echo "Enabling Rosetta for enhanced Docker compatibility..."
   softwareupdate --install-rosetta
   
   echo "Docker has been optimized for M3 Max. Please restart Docker Desktop and configure:"
   echo "- Resources > Memory: 16 GB"
   echo "- Resources > CPUs: 10"
   echo "- Resources > Swap: 2 GB"
   echo "- Features in Development: Enable VirtioFS accelerated directory sharing"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x docker_optimize.sh
   ./docker_optimize.sh
   ```

4. Restart Docker Desktop to apply the changes.

5. Open Docker Desktop Preferences:
   - Go to Resources > Advanced
   - Set Memory to 16 GB
   - Set CPUs to 10
   - Set Swap to 2 GB 
   - Under Features in Development, enable VirtioFS

## Step 3: Install Docker Tools

1. Create a script to install Docker tools:
   ```bash
   cd ~/Developer/setup-scripts
   nano install_docker_tools.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Install Docker tools with Homebrew
   brew install docker-compose
   brew install docker-credential-helper
   brew install lazydocker
   
   # Install dive for exploring Docker images
   brew install dive
   
   # Install ctop for monitoring Docker containers
   brew install ctop
   
   # Add aliases to .zshrc
   cat >> ~/.zshrc << EOF
   
   # Docker tools aliases
   alias ld="lazydocker"
   alias ct="ctop"
   alias dive="dive"
   
   # Docker basics aliases
   alias dps="docker ps"
   alias dimg="docker images"
   alias dstop="docker stop \$(docker ps -q)"
   alias dprune="docker system prune -a --volumes -f"
   alias dcomp="docker-compose"
   alias dcup="docker-compose up"
   alias dcdown="docker-compose down"
   alias dcbuild="docker-compose build"
   alias dcrestart="docker-compose restart"
   alias dcexec="docker-compose exec"
   
   # Helper functions
   dexec() {
     docker exec -it \$1 bash
   }
   EOF
   
   # Source updated .zshrc
   source ~/.zshrc
   
   echo "Docker tools have been installed successfully!"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x install_docker_tools.sh
   ./install_docker_tools.sh
   ```

## Step 4: Set Up Docker Image Cleanup Script

1. Create a script to periodically clean up unused Docker images:
   ```bash
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
   ```bash
   chmod +x docker_cleanup.sh
   ```

4. Set up a periodic cleanup using crontab:
   ```bash
   (crontab -l 2>/dev/null; echo "0 0 * * 0 ~/Developer/setup-scripts/docker_cleanup.sh >> ~/docker_cleanup.log 2>&1") | crontab -
   ```

5. Add an alias to manually run the cleanup:
   ```bash
   echo "alias dclean=\"~/Developer/setup-scripts/docker_cleanup.sh\"" >> ~/.zshrc
   source ~/.zshrc
   ```

## Step 5: Set Up Python Development Environment with Docker

1. Create a directory structure for Python Docker projects:
   ```bash
   mkdir -p ~/Developer/docker-projects/python
   ```

2. Create a script to set up the Python Docker environment:
   ```bash
   cd ~/Developer/setup-scripts
   nano setup_python_docker.sh
   ```

3. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create a Python development directory
   mkdir -p ~/Developer/docker-projects/python
   
   # Create a template Dockerfile for Python development
   cat > ~/Developer/docker-projects/python/Dockerfile.template << EOF
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
   cat > ~/Developer/docker-projects/python/docker-compose.template.yml << EOF
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
   cat > ~/Developer/docker-projects/python/requirements.template.txt << EOF
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
   
   echo "Python Docker development environment has been set up."
   ```

4. Make the script executable and run it:
   ```bash
   chmod +x setup_python_docker.sh
   ./setup_python_docker.sh
   ```

## Step 6: Create Python Project Templates for Docker

1. Create specialized Docker templates for different types of Python projects:
   ```bash
   mkdir -p ~/Developer/docker-templates/python
   ```

2. Create a data science template:
   ```bash
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
   ```bash
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
   ```bash
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
   ```bash
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

## Step 7: Create a Project Generator Script

1. Create a script to generate new Python Docker projects:
   ```bash
   cd ~/Developer/setup-scripts
   nano create_python_project.sh
   ```

2. Add the following content:
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
   PROJECT_DIR=~/Developer/docker-projects/python/$PROJECT_NAME
   
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
       "\n",
       "# Set style\n",
       "sns.set(style='whitegrid')\n",
       "%matplotlib inline"
      ]
     },
     {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "source": [
       "# Your analysis code here"
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 4
   }
   EOF
   
   elif [ "$TEMPLATE_TYPE" = "webapi" ]; then
     mkdir -p app/api
     mkdir -p app/core
     mkdir -p app/db
     mkdir -p app/models
     mkdir -p app/schemas
     mkdir -p tests
     
     # Create main.py
     cat > app/main.py << EOF
   from fastapi import FastAPI
   
   app = FastAPI(title="$PROJECT_NAME API")
   
   @app.get("/")
   def read_root():
       return {"message": "Welcome to $PROJECT_NAME API"}
   
   if __name__ == "__main__":
       import uvicorn
       uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)
   EOF
     
     # Create database models
     cat > app/models/__init__.py << EOF
   # Import your models here
   EOF
     
     # Create schemas
     cat > app/schemas/__init__.py << EOF
   # Import your schemas here
   EOF
     
     # Create database configuration
     cat > app/db/session.py << EOF
   from sqlalchemy import create_engine
   from sqlalchemy.ext.declarative import declarative_base
   from sqlalchemy.orm import sessionmaker
   import os
   
   DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:postgres@db/$PROJECT_NAME")
   
   engine = create_engine(DATABASE_URL)
   SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
   
   Base = declarative_base()
   
   def get_db():
       db = SessionLocal()
       try:
           yield db
       finally:
           db.close()
   EOF
   fi
   
   # Create .env file
   cat > .env.template << EOF
   # Environment variables
   ENVIRONMENT=development
   
   # API configuration
   API_PORT=8000
   
   # Database configuration
   DATABASE_URL=postgresql://postgres:postgres@db/$PROJECT_NAME
   
   # Optional API keys
   OPENAI_API_KEY=
   ANTHROPIC_API_KEY=
   EOF
   
   # Create .gitignore
   cat > .gitignore << EOF
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
   
   # Unit test / coverage reports
   htmlcov/
   .tox/
   .coverage
   .coverage.*
   .cache
   nosetests.xml
   coverage.xml
   *.cover
   .hypothesis/
   
   # Jupyter Notebook
   .ipynb_checkpoints
   
   # Environment
   .env
   .venv
   venv/
   ENV/
   
   # IDE
   .idea/
   .vscode/
   *.swp
   *.swo
   
   # Project specific
   data/*
   !data/.gitkeep
   EOF
   
   # Create README.md
   cat > README.md << EOF
   # $PROJECT_NAME
   
   Python $TEMPLATE_TYPE project with Docker.
   
   ## Getting Started
   
   1. Clone this repository
   2. Copy .env.template to .env and update values
   3. Build and run the Docker container:
   
   \`\`\`bash
   docker-compose up --build
   \`\`\`
   
   ## Project Structure
   EOF
   
   if [ "$TEMPLATE_TYPE" = "datascience" ]; then
     cat >> README.md << EOF
   
   - \`notebooks/\`: Jupyter notebooks
   - \`data/\`: Data files
   - \`scripts/\`: Python scripts
   
   ## Access Jupyter Lab
   
   Open your browser and navigate to:
   
   \`\`\`
   http://localhost:8888
   \`\`\`
   EOF
   
   elif [ "$TEMPLATE_TYPE" = "webapi" ]; then
     cat >> README.md << EOF
   
   - \`app/\`: Main application
     - \`api/\`: API endpoints
     - \`core/\`: Core application code
     - \`db/\`: Database configuration
     - \`models/\`: Database models
     - \`schemas/\`: Pydantic schemas
   - \`tests/\`: Test modules
   
   ## API Documentation
   
   Once the application is running, you can access the API documentation at:
   
   - Swagger UI: \`http://localhost:8000/docs\`
   - ReDoc: \`http://localhost:8000/redoc\`
   EOF
   fi
   
   # Create empty files to maintain directory structure
   if [ "$TEMPLATE_TYPE" = "datascience" ]; then
     touch data/.gitkeep
     touch scripts/.gitkeep
   elif [ "$TEMPLATE_TYPE" = "webapi" ]; then
     touch app/api/__init__.py
     touch app/core/__init__.py
     touch app/db/__init__.py
     touch tests/__init__.py
   fi
   
   # Initialize Git repository
   git init
   git add .
   git commit -m "Initial commit: $PROJECT_NAME $TEMPLATE_TYPE project"
   
   # Create .devcontainer configuration
   mkdir -p .devcontainer
   
   # Create devcontainer.json
   cat > .devcontainer/devcontainer.json << EOF
   {
     "name": "$PROJECT_NAME Development",
     "dockerComposeFile": "../docker-compose.yml",
     "service": "${TEMPLATE_TYPE == 'datascience' ? 'notebook' : 'api'}",
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
     "forwardPorts": [${TEMPLATE_TYPE == 'datascience' ? '8888' : '8000, 5432'}]
   }
   EOF
   
   echo "$PROJECT_NAME $TEMPLATE_TYPE project has been created successfully!"
   echo "To start developing:"
   echo "cd $PROJECT_DIR"
   echo "docker-compose up --build"
   echo "Or open in VS Code and use 'Reopen in Container'"
   ```

3. Make the script executable:
   ```bash
   chmod +x create_python_project.sh
   ```

4. Add an alias for easy access:
   ```bash
   echo "alias pynew=\"~/Developer/setup-scripts/create_python_project.sh\"" >> ~/.zshrc
   source ~/.zshrc
   ```

## Step 8: Set Up Custom Base Images for Development

1. Create a script to build custom base images:
   ```bash
   cd ~/Developer/setup-scripts
   nano build_base_images.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create directory for Docker base images
   mkdir -p ~/Developer/docker-base-images
   cd ~/Developer/docker-base-images
   
   # Create Python data science base image
   mkdir -p python-datascience
   cd python-datascience
   
   # Create Dockerfile
   cat > Dockerfile << EOF
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
   
   # Expose Jupyter port
   EXPOSE 8888
   
   # Command to run when container starts
   CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
   EOF
   
   # Create requirements.txt
   cat > requirements.txt << EOF
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
   black
   isort
   mypy
   pytest
   pytest-cov
   EOF
   
   # Build base image
   docker build -t python-datascience:local .
   
   # Create Python web API base image
   cd ~/Developer/docker-base-images
   mkdir -p python-webapi
   cd python-webapi
   
   # Create Dockerfile
   cat > Dockerfile << EOF
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
   
   # Expose API port
   EXPOSE 8000
   
   # Command to run when container starts
   CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
   EOF
   
   # Create requirements.txt
   cat > requirements.txt << EOF
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
   
   # Development tools
   black
   isort
   mypy
   EOF
   
   # Build base image
   docker build -t python-webapi:local .
   
   echo "Base Docker images have been built successfully!"
   echo "To use these images in your projects, update your Dockerfile to:"
   echo "FROM python-datascience:local"
   echo "or"
   echo "FROM python-webapi:local"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x build_base_images.sh
   ./build_base_images.sh
   ```

## Step 9: Create Docker Compose Templates for Different Scenarios

1. Create a script to generate Docker Compose templates:
   ```bash
   cd ~/Developer/setup-scripts
   nano create_docker_templates.sh
   ```

2. Add the following content:
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
   
   # Create a template for production deployment
   cat > ~/Developer/docker-templates/production-template.yml << EOF
   version: '3.8'
   
   services:
     api:
       build:
         context: .
         dockerfile: Dockerfile.prod
       restart: unless-stopped
       environment:
         - ENVIRONMENT=production
       depends_on:
         - db
       networks:
         - backend
         - frontend
     
     db:
       image: postgres:14
       restart: unless-stopped
       volumes:
         - postgres_data:/var/lib/postgresql/data
       environment:
         - POSTGRES_USER=postgres
         - POSTGRES_PASSWORD=postgres
         - POSTGRES_DB=app
       networks:
         - backend
     
     nginx:
       image: nginx:alpine
       restart: unless-stopped
       volumes:
         - ./nginx.conf:/etc/nginx/conf.d/default.conf
         - ./static:/usr/share/nginx/html/static
       ports:
         - "80:80"
       depends_on:
         - api
       networks:
         - frontend
   
   networks:
     frontend:
     backend:
   
   volumes:
     postgres_data:
   EOF
   
   echo "Docker Compose templates have been created in ~/Developer/docker-templates"
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x create_docker_templates.sh
   ./create_docker_templates.sh
   ```

## Step 10: Set Up a Container Monitoring Dashboard

1. Create a script to set up a container monitoring dashboard:
   ```bash
   cd ~/Developer/setup-scripts
   nano setup_monitoring.sh
   ```

2. Add the following content:
   ```bash
   #!/bin/bash
   
   # Create directory for monitoring setup
   mkdir -p ~/Developer/docker-monitoring
   cd ~/Developer/docker-monitoring
   
   # Create docker-compose.yml for monitoring stack
   cat > docker-compose.yml << EOF
   version: '3.8'
   
   services:
     prometheus:
       image: prom/prometheus:latest
       volumes:
         - ./prometheus.yml:/etc/prometheus/prometheus.yml
         - prometheus_data:/prometheus
       command:
         - '--config.file=/etc/prometheus/prometheus.yml'
         - '--storage.tsdb.path=/prometheus'
         - '--web.console.libraries=/usr/share/prometheus/console_libraries'
         - '--web.console.templates=/usr/share/prometheus/consoles'
       ports:
         - "9090:9090"
       restart: unless-stopped
   
     grafana:
       image: grafana/grafana:latest
       volumes:
         - grafana_data:/var/lib/grafana
       ports:
         - "3000:3000"
       depends_on:
         - prometheus
       restart: unless-stopped
       environment:
         - GF_SECURITY_ADMIN_PASSWORD=admin
         - GF_USERS_ALLOW_SIGN_UP=false
   
     cadvisor:
       image: gcr.io/cadvisor/cadvisor:latest
       volumes:
         - /:/rootfs:ro
         - /var/run:/var/run:ro 
         - /sys:/sys:ro
         - /var/lib/docker/:/var/lib/docker:ro
       ports:
         - "8080:8080"
       restart: unless-stopped
   
   volumes:
     prometheus_data:
     grafana_data:
   EOF
   
   # Create Prometheus configuration
   cat > prometheus.yml << EOF
   global:
     scrape_interval: 15s
     evaluation_interval: 15s
   
   scrape_configs:
     - job_name: 'prometheus'
       static_configs:
         - targets: ['localhost:9090']
   
     - job_name: 'cadvisor'
       static_configs:
         - targets: ['cadvisor:8080']
   EOF
   
   # Create README
   cat > README.md << EOF
   # Docker Monitoring Stack
   
   This directory contains a Docker Compose setup for monitoring Docker containers using Prometheus, Grafana, and cAdvisor.
   
   ## Usage
   
   Start the monitoring stack:
   
   \`\`\`bash
   docker-compose up -d
   \`\`\`
   
   Access the dashboards:
   
   - Grafana: http://localhost:3000 (admin/admin)
   - Prometheus: http://localhost:9090
   - cAdvisor: http://localhost:8080
   
   ## Initial Setup
   
   1. Log in to Grafana (http://localhost:3000) with username 'admin' and password 'admin'
   2. Add Prometheus as a data source (URL: http://prometheus:9090)
   3. Import a dashboard for Docker monitoring (Dashboard ID: 893)
   \`\`\`
   EOF
   
   # Create a startup script
   cat > start_monitoring.sh << EOF
   #!/bin/bash
   
   cd ~/Developer/docker-monitoring
   docker-compose up -d
   
   echo "Monitoring stack started!"
   echo "Access the dashboards at:"
   echo "- Grafana: http://localhost:3000 (admin/admin)"
   echo "- Prometheus: http://localhost:9090"
   echo "- cAdvisor: http://localhost:8080"
   EOF
   
   # Make the script executable
   chmod +x start_monitoring.sh
   
   # Create an alias
   echo "alias dmonitor=\"~/Developer/docker-monitoring/start_monitoring.sh\"" >> ~/.zshrc
   source ~/.zshrc
   
   echo "Docker monitoring stack has been set up."
   echo "Run 'dmonitor' to start the monitoring stack."
   ```

3. Make the script executable and run it:
   ```bash
   chmod +x setup_monitoring.sh
   ./setup_monitoring.sh
   ```

## Step 11: Create Multi-Stage Build Examples

1. Create examples of multi-stage Docker builds:
   ```bash
   mkdir -p ~/Developer/docker-examples/multi-stage
   cd ~/Developer/docker-examples/multi-stage
   ```

2. Create a Python application example:
   ```bash
   mkdir -p python-app
   cd python-app
   ```

3. Create a multi-stage Dockerfile:
   ```bash
   cat > Dockerfile << EOF
   # Build stage
   FROM python:3.12-slim AS builder
   
   WORKDIR /app
   
   # Install build dependencies
   RUN apt-get update && apt-get install -y \
       build-essential \
       && rm -rf /var/lib/apt/lists/*
   
   # Create and activate virtual environment
   RUN python -m venv /opt/venv
   ENV PATH="/opt/venv/bin:$PATH"
   
   # Install Python dependencies
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt
   
   # Final stage
   FROM python:3.12-slim
   
   WORKDIR /app
   
   # Copy virtual environment from builder stage
   COPY --from=builder /opt/venv /opt/venv
   ENV PATH="/opt/venv/bin:$PATH"
   
   # Copy application code
   COPY . .
   
   # Run application
   CMD ["python", "app.py"]
   EOF
   ```

4. Create a sample application:
   ```bash
   cat > app.py << EOF
   def main():
       print("Hello from multi-stage Docker build!")
   
   if __name__ == "__main__":
       main()
   EOF
   ```

5. Create a requirements file:
   ```bash
   cat > requirements.txt << EOF
   numpy
   pandas
   requests
   EOF
   ```

## Summary

This setup guide provides a comprehensive approach to setting up Docker and container development on your MacBook Pro M3 Max. The key components include:

1. **Docker Desktop Installation and Optimization** for M3 Max hardware
2. **Docker Tools and Utilities** for managing containers
3. **Python Development Environment in Docker** with templates for different project types
4. **Base Images and Templates** for efficient development
5. **Container Monitoring** for performance tracking
6. **Multi-Stage Builds** for production-ready applications

After completing these steps, you'll have a powerful and efficient containerized development environment specifically optimized for your M3 Max hardware.

## Usage Examples

### Create a New Python Data Science Project

```bash
pynew my-analysis datascience
cd ~/Developer/docker-projects/python/my-analysis
docker-compose up
```

### Create a New Python Web API Project

```bash
pynew my-api webapi
cd ~/Developer/docker-projects/python/my-api
docker-compose up
```

### Monitor Docker Resources

```bash
dmonitor
```

### Clean Up Docker Resources

```bash
dclean
```

### Start a Docker Shell for a Project

```bash
cd ~/Developer/docker-projects/python/my-project
docker-compose run app bash
```

### Explore a Docker Image

```bash
dive <image-name>
```

### Monitor Docker Containers

```bash
ct
```

### Manage Docker with a Terminal UI

```bash
ld
```