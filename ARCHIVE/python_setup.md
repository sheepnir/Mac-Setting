# Project Setup Guide

Welcome! This guide will walk you through creating a new Python project on your Mac. You'll learn how to:

- Install and manage Python versions
- Clone your GitHub repository
- Use a shared virtual environment
- Install dependencies
- Scaffold and run a simple script
- Work in VS Code
- Commit and push your code

Everything is described step by step. Let’s get started.

---

## Prerequisites: Your Toolbox

Before you begin, make sure you have:

1. **Homebrew** (the macOS package manager)
   - Check by running `brew --version` in Terminal.
   - If you see a version number, you’re good.
   - If you see “command not found,” install with:
     ```bash
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```
2. **Python 3**
   - Homebrew can install the latest version: `brew install python`
   - Verify with `python3 --version`.
3. **Git and GitHub**
   - Check `git --version`.
   - A GitHub account and at least one repository where you'll store your code.
4. **Visual Studio Code (VS Code)**
   - Download from https://code.visualstudio.com/ or install via Homebrew Cask: `brew install --cask visual-studio-code`
   - Make sure the `code` command is available: open VS Code, press ⇧⌘P, type **Shell Command: Install 'code' command**, and select it.

---

## 1. Clone Your GitHub Repository

1. In GitHub’s web interface, navigate to your repo and click **Code → SSH** or **HTTPS**, then copy the URL.
2. Open **Terminal** (Finder → Applications → Utilities → Terminal).
3. Run:
   ```bash
   git clone <your-repo-url> my-python-project
   cd my-python-project
   ```
   - Replace `<your-repo-url>` with the URL you copied.
   - `my-python-project` is the local folder name; you can choose any name.

You now have a local copy of your remote repo.

---

## 2. Prepare Your Python Environment

We keep all our work in a single, shared virtual environment to avoid installing packages globally.

1. **Location**: `~/.venvs/python-dev` (hidden folder in your Home directory).
2. **Activate it**:
   ```bash
   source ~/.venvs/python-dev/bin/activate
   ```
3. Your Terminal prompt should change to `(python-dev)`, meaning all `pip` and `python` commands now use that isolated environment.

> **Note:** If you haven’t created this venv yet, run:
> ```bash
> python3 -m venv ~/.venvs/python-dev
> ```

---

## 3. Create and Install Dependencies

1. Inside your project folder, create a file named `requirements.txt`:
   ```bash
   touch requirements.txt
   ```
2. Open `requirements.txt` in an editor and list the libraries your project needs, for example:
   ```text
   requests
   numpy
   pandas
   ```
3. Save, then install everything with:
   ```bash
   pip install -r requirements.txt
   ```
4. When you add new packages later, run `pip install <package>` then `pip freeze > requirements.txt` to update the list.

---

## 4. Ignore Unnecessary Files

Create a `.gitignore` file so Git skips system and editor files:

```bash
touch .gitignore
```

Paste in:
```gitignore
# Python cache
__pycache__/
*.pyc

# Virtual environment
.venv/

# VS Code settings
.vscode/
```
Save the file.

---

## 5. Scaffold a Simple Script

1. Create `main.py`:
   ```bash
   touch main.py
   ```
2. Open `main.py` in your editor and add:
   ```python
   # main.py

   def main():
       print("Hello, Python World!")

   if __name__ == '__main__':
       main()
   ```
3. Save.

This script prints a friendly greeting—your first step toward building something bigger!

---

## 6. Run Your Script

In Terminal (with `(python-dev)` active):
```bash
python main.py
```
You should see:
```
Hello, Python World!
```
If you do, congrats—your setup works!

---

## 7. Open and Work in VS Code

1. In Terminal, type:
   ```bash
   code .
   ```
2. VS Code opens your project folder. Recommended extensions:
   - **Python** (ms-python.python)
   - **Pylance** (ms-python.vscode-pylance)
   - **Black Formatter** (ms-python.black-formatter)
   - **isort** (ms-python.isort)
   - **Autodocstring** (njpwerner.autodocstring)
   - **Jupyter** (ms-toolsai.jupyter)
   - **Beautify** (HookyQR.beautify)
   - **HTML/CSS Support** (ecmel.vscode-html-css)
   - **Copilot** (GitHub.copilot)

When you save a file, Black and isort will reformat automatically.

---

## 8. Commit and Push Your Changes

1. Check what’s new:
   ```bash
   git status
   ```
2. Stage files:
   ```bash
   git add .
   ```
3. Commit with a clear message:
   ```bash
   git commit -m "chore: project scaffold and initial setup"
   ```
4. Push to GitHub:
   ```bash
   git push -u origin main
   ```

Your code is now safely stored in your remote repo.

---

## What’s Next?

- Add your own Python modules and functions.
- Write and run tests (e.g. with `pytest`).
- Manage configuration and secrets with environment variables or `.env` files.
- Explore Continuous Integration (CI) to run tests on every push.
- Learn more at the [official Python docs](https://docs.python.org/3/).

Happy coding—and welcome to Python development! 🚀

