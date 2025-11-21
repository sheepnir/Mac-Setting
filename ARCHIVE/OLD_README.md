# Clean Install macOS Sonoma on MacBook Pro M3 Max

This guide provides step-by-step instructions for wiping and reinstalling a clean version of macOS Sonoma on your MacBook Pro M3 Max with 36 GB of RAM.

## Before You Begin

- Ensure your MacBook is connected to a power source throughout this process.
- Make sure you have a stable internet connection.

## Step 1: Back Up Your Data

1. Connect an external hard drive to your MacBook.
2. Open Time Machine from System Settings.
3. Select your external drive as the backup disk.
4. Click "Back Up Now" and wait for the process to complete.

## Step 2: Sign Out of Apple Services

1. Open the Apple menu and go to System Settings.
2. Click on your Apple ID at the top.
3. Scroll down and click "Sign Out".
4. Follow the prompts to turn off Find My Mac.

## Step 3: Erase Your MacBook

1. Restart your MacBook and immediately press and hold the power button until you see the startup options.
2. Select "Options" and click "Continue".
3. Choose a language if prompted.
4. Select "Disk Utility" and click "Continue".
5. In Disk Utility, select "Macintosh HD" in the sidebar.
6. Click "Erase" at the top of the window.
7. Name: Macintosh HD
   Format: APFS
   Scheme: GUID Partition Map
8. Click "Erase".
9. If you have other internal volumes, repeat steps 5-8 for each.
10. Once done, close Disk Utility.

## Step 4: Reinstall macOS Sonoma

1. In the macOS Recovery window, select "Reinstall macOS Sonoma".
2. Click "Continue" and follow the on-screen instructions.
3. Select "Macintosh HD" as the installation destination.
4. Wait for the installation to complete. Your Mac may restart several times.

## Step 5: Set Up Your Mac

1. Once the installation is complete, your Mac will restart.
2. Follow the setup assistant to configure your new macOS installation.
3. Choose whether to restore from your Time Machine backup or set up as a new Mac.

## Step 6: Verify and Update

1. Once setup is complete, check System Settings > General > Software Update to ensure you have the latest version of macOS Sonoma.
2. Install any available updates.

Congratulations! You now have a clean installation of macOS Sonoma on your MacBook Pro M3 Max.

## Step 7: Configure Finder Settings

After completing the clean install and initial setup, you can configure your Finder settings using a custom script. Follow these steps:

1. Open a Terminal and Create a folder Developer in the home folder.
2. Copy and paste the following script into a new file:

   ```bash
   #!/bin/bash

   # Set Finder view to List
   defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

   # Sort by Date Added
   defaults write com.apple.Finder FXArrangeGroupViewBy -string "dateAdded"

   # Show toolbar
   defaults write com.apple.Finder ShowToolbar -bool true

   # Show path bar
   defaults write com.apple.Finder ShowPathbar -bool true

   # Show status bar
   defaults write com.apple.Finder ShowStatusBar -bool true

   # Show hidden files
   defaults write com.apple.Finder AppleShowAllFiles -bool true

   # Show all file extensions
   defaults write NSGlobalDomain AppleShowAllExtensions -bool true

   # When performing a search, search the current folder by default
   defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

   # Set sidebar items
   defaults write com.apple.finder sidebar-items -dict-add \
       AirDrop -dict-add ShowInSidebar -bool true \
       Applications -dict-add ShowInSidebar -bool true \
       Desktop -dict-add ShowInSidebar -bool true \
       Documents -dict-add ShowInSidebar -bool true \
       Downloads -dict-add ShowInSidebar -bool true \
       HomeDirectory -dict-add ShowInSidebar -bool true \
       iCloud -dict-add ShowInSidebar -bool true \
       NetworkDiskMode -dict-add ShowInSidebar -bool true

   # Uncheck all tags in sidebar
   defaults write com.apple.finder ShowRecentTags -bool false

   # New Finder windows show Downloads
   defaults write com.apple.finder NewWindowTarget -string "PfLo"
   defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

   # Restart Finder to apply changes
   killall Finder

   echo "Finder preferences have been updated successfully!"
   ```

3. Save the file with a `.sh` extension (e.g., `setup_finder.sh`) in a location you can easily access, such as your Desktop.
4. Open Terminal (you can find it in Applications > Utilities or use Spotlight to search for it).
5. In Terminal, navigate to the directory where you saved the script. If you saved it on your Desktop, you can use this command:
   ```
   cd ~/Desktop
   ```
6. Make the script executable by running:
   ```
   chmod +x setup_finder.sh
   ```
7. Run the script with:
   ```
   ./setup_finder.sh
   ```
8. You may be prompted to enter your administrator password. This is necessary because the script modifies system settings.
9. After the script runs, your Finder will restart with the new settings applied.

This script will configure Finder with the following settings:

- View as a List
- Sort by Date Added
- Show toolbar, path bar, and status bar
- Show hidden files
- Show all file extensions
- When performing a search, search the current folder
- Set the sidebar to show only: AirDrop, Applications, Desktop, Documents, Downloads, Home folder, iCloud Drive, and Shared
- Uncheck all tags in the sidebar
- New Finder windows will show the Downloads folder

## Step 8: Install Homebrew

After setting up Finder, we'll install Homebrew, which is a package manager for macOS. This process will also install Xcode Command Line Tools if they're not already installed.

1. Open Terminal (you can find it in Applications > Utilities or use Spotlight to search for it).

2. Install Homebrew by running the following command:

   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. Follow the prompts in the Terminal. You may be asked to enter your password.

4. After the installation is complete, you might need to add Homebrew to your PATH. The installation script will tell you if this is necessary and provide the commands to do so. Typically, for Apple Silicon Macs, you'll need to run these commands:

   ```
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

5. Verify the installation by running:
   ```
   brew --version
   ```
   If Homebrew is installed correctly, this command will return the version number.

## Step 9: Install 1Password

Now that Homebrew is installed, we can use it to install 1Password.

1. In Terminal, run the following command to install 1Password:

   ```
   brew install --cask 1password
   ```

2. Follow any on-screen prompts to complete the installation.

3. Once installed, launch 1Password and sign in to your account.

## Step 10: Create Setup Scripts Folder

We'll create a dedicated folder to store our setup scripts.

1. In Terminal, run the following commands to create the folder and navigate to it:
   ```
   mkdir -p /home/developer/setup-scripts
   cd /home/developer/setup-scripts
   ```


## Step 13: Install and Configure Oh My Zsh

Oh My Zsh is a framework for managing your Zsh configuration. We'll install it and set up the theme and plugins you specified.

1. First, let's create a script to automate the Oh My Zsh installation and configuration. In Terminal, ensure you're in the `/home/developer/setup-scripts` directory, then run:

   ```
   nano setup_ohmyzsh.sh
   ```

2. In the nano editor, paste the following script:

   ```bash
   #!/bin/bash

   # Install Oh My Zsh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

   # Set the theme
   sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="half-life"/' ~/.zshrc

   # Set the plugins
   sed -i '' 's/plugins=(git)/plugins=(git macos web-search)/' ~/.zshrc

   # Source the updated .zshrc file
   source ~/.zshrc

   echo "Oh My Zsh has been installed and configured!"
   ```

3. Save the file and exit nano by pressing `Ctrl+X`, then `Y`, then `Enter`.

4. Make the script executable by running:

   ```
   chmod +x setup_ohmyzsh.sh
   ```

5. Run the Oh My Zsh setup script:

   ```
   ./setup_ohmyzsh.sh
   ```

6. The script will install Oh My Zsh, set the theme to "half-life", and add the git, macos, and web-search plugins.

7. After the script finishes, close and reopen your Terminal to see the changes take effect.

This script does the following:

- Installs Oh My Zsh
- Sets the ZSH_THEME to "half-life"
- Configures the plugins to include git, macos, and web-search
- Sources the updated .zshrc file to apply the changes

Your Terminal should now be using the Oh My Zsh framework with the specified theme and plugins.

## Step 14: Install Utilities

We'll now install several useful utilities using Homebrew.

1. Create a new script to install the utilities. In Terminal, ensure you're in the `/home/developer/setup-scripts` directory, then run:

   ```
   nano install_utilities.sh
   ```

2. In the nano editor, paste the following script:

   ```bash
   #!/bin/bash

   # Install utilities using Homebrew
   brew install --cask warp
   brew install --cask google-chrome
   brew install --cask brave-browser
   brew install --cask chatgpt
   brew install --cask visual-studio-code
   brew install --cask slack
   brew install --cask zoom

   echo "Utilities have been installed successfully!"
   ```

3. Save the file and exit nano by pressing `Ctrl+X`, then `Y`, then `Enter`.

4. Make the script executable by running:

   ```
   chmod +x install_utilities.sh
   ```

5. Run the utilities installation script:
   ```
   ./install_utilities.sh
   ```


## Step 18: Install Productivity Tools

We'll now install several productivity tools and set some system defaults.

1. Create a new script to install the productivity tools. In Terminal, ensure you're in the `/home/developer/setup-scripts` directory, then run:

   ```
   nano install_productivity_tools.sh
   ```

2. In the nano editor, paste the following script:

   [Insert the productivity-tools-install-script here]

3. Save the file and exit nano by pressing `Ctrl+X`, then `Y`, then `Enter`.

4. Make the script executable by running:

   ```
   chmod +x install_productivity_tools.sh
   ```

5. Before running the script, we need to install `duti`, which is used to set default applications. Run:

   ```
   brew install duti
   ```

6. Run the productivity tools installation script:
   ```
   ./install_productivity_tools.sh
   ```

This script will:

- Install the following applications using Homebrew:
  - Firefox
  - Evernote
  - Raycast
  - Bartender
  - AppCleaner
  - AlDente
  - Grammarly
  - Sublime Text
  - Microsoft Word, Excel, and PowerPoint
- Set Brave as the default browser
- Set Sublime Text as the default text editor for plain text files, Unix executables, and source code files

Note: Setting default applications might require you to confirm the changes in System Settings > Desktop & Dock > Default web browser and System Settings > Desktop & Dock > Default app for opening documents.

After running the script, you may need to restart your computer or log out and log back in for all changes to take effect.

## Step 19: Set Up Python for Development

We'll now set up Python for development using Miniconda, which is ideal for data science projects. This setup will work seamlessly with VSCode.

1. Create a new script to set up Python. In Terminal, ensure you're in the `/home/developer/setup-scripts` directory, then run:

   ```
   nano setup_python_dev.sh
   ```

2. In the nano editor, paste the following script:

   [Insert the updated python-dev-setup-script here]

3. Save the file and exit nano by pressing `Ctrl+X`, then `Y`, then `Enter`.

4. Make the script executable by running:

   ```
   chmod +x setup_python_dev.sh
   ```

5. Run the Python setup script:

   ```
   ./setup_python_dev.sh
   ```

6. After the script finishes, close and reopen your terminal or run `source ~/.zshrc` to ensure the conda initialization takes effect.

This script will:

- Install Miniconda using Homebrew
- Initialize conda for zsh
- Create a new conda environment called 'testproject' with the latest stable Python version
- Add conda-forge to the channels for a wider selection of packages
- Install essential data science packages (numpy, pandas, matplotlib, seaborn, scikit-learn, jupyter) in the 'testproject' environment
- Attempt to install openai and anthropic packages using conda, falling back to pip if necessary
- Install the Python and Jupyter extensions for VSCode

After running the script:

7. Open VSCode and ensure it recognizes your conda environments:

   - Open the Command Palette (Cmd+Shift+P)
   - Type "Python: Select Interpreter"
   - Choose the 'testproject' environment you just created

8. To start a new Python project in VSCode:

   - Open a new or existing project folder
   - Create a new Python file or Jupyter notebook
   - VSCode should automatically use the 'testproject' environment

9. To activate your test project environment in the terminal, run:
   ```
   conda activate testproject
   ```

Remember to activate the 'testproject' environment whenever you're working on your projects. You can create additional environments for other projects as needed.

Note: If you need to install additional packages in the future, you can use either `conda install package_name` or `pip install package_name` while your 'testproject' environment is activated.
