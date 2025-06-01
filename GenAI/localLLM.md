# Ollama + Open WebUI Setup Guide for MacBook Air M4

This guide will help you set up a local LLM environment on your MacBook Air M4 using Ollama and Open WebUI, perfect for business document writing and project management.

## Prerequisites

- MacBook Air M4 with macOS 14.0 or later
- At least 16GB RAM (recommended for better performance)
- 20-50GB free storage space (depending on models you choose)
- Homebrew package manager

## Step 1: Install Homebrew (if not already installed)

### Useful Model Commands

```bash
# List installed models
ollama list

# Remove a model
ollama rm model_name

# Update a model
ollama pull model_name

# Check Ollama status
ollama ps

# Get detailed model info
ollama show model_name

# Test a model quickly
ollama run model_name "Write a brief professional email"

# Stop a running model (frees memory)
ollama stop model_name
```

### Model Storage Locations

Models are stored in:
```bash
# macOS default location
~/.ollama/models

# Check disk usage
du -sh ~/.ollama/models
```

### Tips for Model Management

1. **Start small**: Begin with 3B-7B models, upgrade as needed
2. **Monitor RAM**: Check Activity Monitor when switching models
3. **Clean up regularly**: Remove unused models to save space
4. **Test before committing**: Try models with `ollama run` before using in projects
5. **Keep favorites**: Maintain 2-3 go-to models for different tasks

### Model Switching Workflow

For efficient model management:
```bash
# Morning routine - start your preferred model
ollama run llama3.1:8b

# Switch for specific tasks
ollama stop llama3.1:8b
ollama run mistral:7b

# Quick test of new model
ollama pull qwen2.5:7b
ollama run qwen2.5:7b "Test prompt here"
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Step 2: Install Ollama

### Option A: Direct Download (Recommended)
1. Visit [ollama.ai](https://ollama.ai)
2. Download the macOS installer
3. Run the installer and follow the setup wizard

### Option B: Using Homebrew
```bash
brew install ollama
```

## Step 3: Start Ollama Service

```bash
# Start Ollama as a service
ollama serve
```

Keep this terminal window open, or run it in the background:
```bash
# To run in background
nohup ollama serve &
```

## Step 4: Install Recommended LLM Models

Here are 4 excellent models for business document writing on M4 MacBook Air:

### 1. Llama 3.1 8B (Recommended for balanced performance)
```bash
ollama pull llama3.1:8b
```
- **Best for**: General business writing, emails, reports
- **Memory usage**: ~5-6GB
- **Speed**: Very fast on M4

### 2. Mistral 7B (Great for professional writing)
```bash
ollama pull mistral:7b
```
- **Best for**: Professional documents, analysis, summaries
- **Memory usage**: ~4-5GB
- **Speed**: Excellent on M4

### 3. Code Llama 7B (For technical documentation)
```bash
ollama pull codellama:7b
```
- **Best for**: Technical documents, process documentation
- **Memory usage**: ~4-5GB
- **Speed**: Fast on M4

### 4. Phi-3 Medium (Efficient and capable)
```bash
ollama pull phi3:medium
```
- **Best for**: Quick tasks, drafts, brainstorming
- **Memory usage**: ~3-4GB
- **Speed**: Very fast on M4

## Step 5: Install Docker (Required for Open WebUI)

```bash
# Install Docker Desktop
brew install --cask docker
```

Launch Docker Desktop from Applications and complete the setup.

## Step 6: Install Open WebUI

### Using Docker (Recommended)
```bash
# Pull and run Open WebUI
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

### Alternative: Using pip (if you prefer)
```bash
pip install open-webui
open-webui serve
```

## Step 7: Access Open WebUI

1. Open your web browser
2. Navigate to `http://localhost:3000`
3. Create your admin account (first user becomes admin)
4. Complete the initial setup

## Step 8: Configure Open WebUI with Ollama

1. In Open WebUI, go to **Settings** (gear icon)
2. Navigate to **Connections**
3. Set Ollama API URL to: `http://host.docker.internal:11434`
4. Click **Verify Connection** to test
5. Your installed models should appear automatically

## Step 9: Setup Projects and Memory

### Creating Projects
1. Click on **Workspaces** in the sidebar
2. Create a new workspace for each business area (e.g., "Marketing", "Reports", "Emails")
3. Each workspace maintains separate conversation history

### Setting Up Memory/Profile
1. Go to **Settings** → **Account**
2. Fill in your **Profile Information**:
   - Name, role, company
   - Writing preferences
   - Common project types
3. Use **System Prompts** to set context:
   ```
   You are assisting [Your Name], a [Your Role] at [Company]. 
   Focus on professional business writing with a [tone preference] tone. 
   Common tasks include: reports, emails, proposals, and analysis.
   ```

### Custom Instructions for Business Writing
In Settings → **Interface** → **Default Model Parameters**, add:
```
Always write in a professional business tone. Structure documents with clear headings, bullet points where appropriate, and executive summaries for longer documents. Focus on clarity, conciseness, and actionable insights.
```

## Step 10: Useful Commands & Tips

## Model Management

### Installing New Models

**Browse available models:**
Visit [Ollama Library](https://ollama.ai/library) or use:
```bash
# Search for models (requires web search)
# Visit ollama.ai/library to browse all available models
```

**Install a new model:**
```bash
# General syntax
ollama pull model_name:tag

# Examples
ollama pull llama3.2:3b          # Smaller, faster model
ollama pull qwen2.5:7b           # Great for business writing
ollama pull gemma2:9b            # Google's model
ollama pull deepseek-coder:6.7b  # Coding specialist
ollama pull solar:10.7b          # Excellent reasoning
```

**Popular models for business writing:**
```bash
# Lightweight options (< 4GB RAM)
ollama pull llama3.2:3b          # Fast, good quality
ollama pull phi3:mini            # Microsoft's efficient model
ollama pull qwen2.5:3b           # Excellent for text

# Medium models (4-8GB RAM)
ollama pull llama3.1:8b          # Recommended balance
ollama pull mistral:7b           # Professional writing
ollama pull qwen2.5:7b           # Strong reasoning

# Larger models (8-16GB RAM)
ollama pull llama3.1:70b         # Highest quality (if you have RAM)
ollama pull qwen2.5:14b          # Very capable
```

### Managing Installed Models

**List all installed models:**
```bash
ollama list
```

**See model details:**
```bash
ollama show model_name
```

**Check running models:**
```bash
ollama ps
```

### Removing Models

**Remove a specific model:**
```bash
ollama rm model_name:tag

# Examples
ollama rm llama3.1:8b
ollama rm mistral:7b
```

**Remove all versions of a model:**
```bash
ollama rm model_name
```

**Free up space - remove unused models:**
```bash
# List models first
ollama list

# Remove the ones you don't use
ollama rm model1 model2 model3
```

### Updating Models

**Update a specific model:**
```bash
ollama pull model_name:tag
```

**Update all models (manual process):**
```bash
# List current models
ollama list

# Pull each one again to update
ollama pull llama3.1:8b
ollama pull mistral:7b
# etc.
```

### Switching Models in Open WebUI

**Method 1: Model Selector**
1. In Open WebUI chat interface
2. Click the model dropdown at the top
3. Select your desired model
4. Start chatting with the new model

**Method 2: Model Settings**
1. Go to **Settings** → **Models**
2. Set your **Default Model**
3. Enable/disable specific models
4. Reorder models by preference

**Method 3: Per-Chat Model Selection**
1. Start a new chat
2. Select model before first message
3. Each chat remembers its model choice

### Model Recommendations by Use Case

**For Fast Responses (RAM < 8GB):**
```bash
ollama pull phi3:mini        # 2GB - Very fast
ollama pull llama3.2:3b      # 2GB - Good balance
ollama pull qwen2.5:3b       # 2GB - Excellent text
```

**for Business Writing (RAM 8-16GB):**
```bash
ollama pull llama3.1:8b      # 5GB - Best overall
ollama pull mistral:7b       # 4GB - Professional tone
ollama pull qwen2.5:7b       # 4GB - Strong reasoning
```

**For Maximum Quality (RAM > 16GB):**
```bash
ollama pull qwen2.5:14b      # 8GB - Very capable
ollama pull llama3.1:70b     # 40GB - Highest quality
```

### Useful Model Commands

### Performance Tips for M4 MacBook Air

1. **Close unnecessary applications** when using larger models
2. **Use Llama 3.1 8B or Mistral 7B** for best balance of quality and speed
3. **Monitor Activity Monitor** to track memory usage
4. **Set temperature to 0.3-0.7** for business writing (less creative, more consistent)

### Recommended Workflows

1. **Email Writing**: Use Mistral 7B with temperature 0.4
2. **Report Generation**: Use Llama 3.1 8B with temperature 0.5
3. **Technical Docs**: Use Code Llama 7B with temperature 0.3
4. **Quick Tasks**: Use Phi-3 Medium with temperature 0.6

## Service Management

### Shutting Down Services

**Stop Ollama:**
```bash
# Find and kill Ollama process
pkill ollama

# Or if you want to be more specific
ps aux | grep ollama
kill [process_id]
```

**Stop Open WebUI (Docker version):**
```bash
# Stop the container
docker stop open-webui

# Or stop and remove it completely
docker stop open-webui && docker rm open-webui
```

**Stop Open WebUI (pip version):**
```bash
# If running in foreground, just press Ctrl+C
# If running in background, find and kill the process
ps aux | grep "open-webui"
kill [process_id]
```

### Restarting Services

**Restart Ollama:**
```bash
# Start Ollama again
ollama serve

# Or run in background
nohup ollama serve > /dev/null 2>&1 &
```

**Restart Open WebUI (Docker version):**
```bash
# If you just stopped it
docker start open-webui

# If you removed it, recreate it
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

**Restart Open WebUI (pip version):**
```bash
open-webui serve
```

### Quick Restart Script

Create a restart script (`restart_llm.sh`):
```bash
#!/bin/bash
echo "Stopping services..."

# Stop Ollama
pkill ollama

# Stop Open WebUI Docker container
docker stop open-webui

echo "Waiting 3 seconds..."
sleep 3

echo "Starting services..."

# Start Ollama in background
nohup ollama serve > /dev/null 2>&1 &

# Start Open WebUI
docker start open-webui

echo "Services restarted! Open WebUI available at http://localhost:3000"
```

Make it executable:
```bash
chmod +x restart_llm.sh
./restart_llm.sh
```

### Check Service Status

To verify services are running:
```bash
# Check Ollama
ps aux | grep ollama

# Check Open WebUI Docker container
docker ps | grep open-webui

# Test Ollama API
curl http://localhost:11434/api/tags
```

## Troubleshooting

### Common Issues

**Ollama not connecting to Open WebUI:**
```bash
# Check if Ollama is running
ps aux | grep ollama

# Restart Ollama
pkill ollama
ollama serve
```

**Docker issues:**
```bash
# Restart Open WebUI container
docker restart open-webui

# Check container logs
docker logs open-webui
```

**Memory issues:**
- Close other applications
- Use smaller models (Phi-3 Medium)
- Restart your Mac if needed

## Starting Your Setup Daily

Create a simple startup script (`start_llm.sh`):
```bash
#!/bin/bash
# Start Ollama
ollama serve &

# Wait a bit
sleep 5

# Start Open WebUI (if not using Docker)
# open-webui serve &

# Open browser
open http://localhost:3000

echo "LLM environment is ready!"
```

Make it executable:
```bash
chmod +x start_llm.sh
./start_llm.sh
```

## Next Steps

1. **Experiment with different models** to find your preferred one for different tasks
2. **Create custom prompts** for recurring document types
3. **Set up document templates** in Open WebUI
4. **Explore the API** if you want to integrate with other tools
5. **Join the community** at [Open WebUI Discord](https://discord.gg/5rJgQTnV4s)

## Resources

- [Ollama Documentation](https://github.com/ollama/ollama)
- [Open WebUI Documentation](https://docs.openwebui.com/)
- [Model Library](https://ollama.ai/library)
- [Community Prompts](https://openwebui.com/prompts/)

---

**Enjoy your local LLM setup! 🚀**

Your MacBook Air M4 is well-equipped to handle these models efficiently. Start with Llama 3.1 8B for the best overall experience in business document writing.