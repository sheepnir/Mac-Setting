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

1. Open a text editor (such as TextEdit).
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

Before we configure the Dock, we need to install Homebrew, which is a package manager for macOS. This process will also install Xcode Command Line Tools if they're not already installed.

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

## Step 9: Configure Dock Settings

Now that Homebrew is installed, we can proceed with configuring your Dock using a custom script. This script will clear the Dock and add only the specified applications and folders. Follow these steps:

1. First, install `dockutil`, a command-line utility for managing the macOS Dock:

   ```
   brew install dockutil
   ```

2. Open a text editor (such as TextEdit).

3. Copy and paste the following script into a new file:

   ```bash
   #!/bin/bash

   # Check if dockutil is installed
   if ! command -v dockutil &> /dev/null
   then
       echo "dockutil is not installed. Please install it first."
       echo "You can install it using Homebrew: brew install dockutil"
       exit 1
   fi

   # Remove all items from Dock
   dockutil --remove all

   # Add desired apps to Dock
   dockutil --add /System/Applications/Finder.app
   dockutil --add /Applications/Safari.app
   dockutil --add /System/Applications/System\ Settings.app
   dockutil --add /System/Applications/Utilities/Terminal.app
   dockutil --add /System/Applications/Messages.app

   # Add Applications folder to Dock
   dockutil --add /Applications --view grid --display folder

   # Add Downloads folder to Dock
   dockutil --add ~/Downloads --view fan --display folder

   # Set Dock to show only open applications
   defaults write com.apple.dock static-only -bool true

   # Restart Dock to apply changes
   killall Dock

   echo "Dock has been successfully configured!"
   ```

4. Save the file with a `.sh` extension (e.g., `setup_dock.sh`) in a location you can easily access, such as your Desktop.

5. In Terminal, navigate to the directory where you saved the script. If you saved it on your Desktop, you can use this command:

   ```
   cd ~/Desktop
   ```

6. Make the script executable by running:

   ```
   chmod +x setup_dock.sh
   ```

7. Run the script with:

   ```
   ./setup_dock.sh
   ```

8. You may be prompted to enter your administrator password. This is necessary because the script modifies system settings.

This script will configure your Dock with the following settings:

- Clear all existing items from the Dock
- Add only Finder, Safari, Settings, Terminal, and Messages apps
- Add the Applications folder, displayed as a folder with grid view
- Add the Downloads folder, displayed as a folder with fan view
- Set the Dock to show only open applications

After running the script, your Dock will restart with the new configuration applied.
