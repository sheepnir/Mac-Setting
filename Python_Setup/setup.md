# Python Development Environment Setup on MacBook

## Prerequisites
- macOS
- Homebrew installed
- VSCode installed

---

## Step 1: Install Homebrew (if missing)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
```

---

## Step 2: Install Python (latest)
```bash
brew install python
```
- This installs a clean `python3` and `pip3`.

---

## Step 3: Set up Virtual Environment Support
```bash
pip3 install virtualenv
mkdir ~/.venvs
```

---

## Step 4: Configure VSCode
Install these VSCode extensions:
- **Python** (Microsoft)
- **Pylance**
- **Jupyter** (optional, for notebooks)

---

## Step 5: Create Your First Project
```bash
mkdir ~/Developer/my-python-project
cd ~/Developer/my-python-project
python3 -m venv venv
source venv/bin/activate
```
- `which python` should now point to `~/Developer/my-python-project/venv/bin/python`.

---

## Step 6: Install Project Dependencies
```bash
pip install requests flask openai
```
(or any other libraries needed)

---

## Step 7: Set Up `.gitignore`
Create a `.gitignore` file in your project folder:
```
venv/
__pycache__/
*.pyc
```

---

## Step 8: Switching Projects
- **Deactivate current environment**:
  ```bash
  deactivate
  ```
- **Switch to another project**:
  ```bash
  cd ~/Developer/another-project
  source venv/bin/activate
  ```

---

## Notes
- Each project has its own `venv/`.
- Always activate the environment when working on a project.
- Always deactivate before switching or exiting.
