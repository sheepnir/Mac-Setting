# Clean Install macOS Sonoma on MacBook Pro M3 Max

[... Previous steps remain unchanged ...]

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

## Step 15: Update Dock Configuration

Now that we've installed new applications, let's update the Dock configuration.

1. Create a new script to update the Dock. In Terminal, run:
   ```
   nano update_dock.sh
   ```

2. In the nano editor, paste the following script:

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
   dockutil --add /Applications/Warp.app
   dockutil --add /Applications/Google\ Chrome.app
   dockutil --add /Applications/Brave\ Browser.app
   dockutil --add /System/Applications/Messages.app
   dockutil --add /System/Applications/App\ Store.app
   dockutil --add /System/Applications/System\ Settings.app
   dockutil --add /Applications/Slack.app
   dockutil --add /Applications/Visual\ Studio\ Code.app
   dockutil --add /Applications/ChatGPT.app

   # Add Downloads folder to Dock
   dockutil --add ~/Downloads --view fan --display folder

   # Restart Dock to apply changes
   killall Dock

   echo "Dock has been successfully updated!"
   ```

3. Save the file and exit nano by pressing `Ctrl+X`, then `Y`, then `Enter`.

4. Make the script executable by running:
   ```
   chmod +x update_dock.sh
   ```

5. Run the Dock update script:
   ```
   ./update_dock.sh
   ```

Your Dock will now be configured with the newly installed applications in the specified order.

