#!/bin/bash

# Check if Homebrew is installed, install if missing
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"  # Set brew in PATH for Apple Silicon
fi

# Check if dockutil is installed, install if missing
if ! command -v dockutil &> /dev/null; then
    echo "dockutil not found. Installing dockutil..."
    brew install dockutil
fi

# Remove all items from Dock
dockutil --remove all --no-restart

# Add essential apps back
essential_apps=(
    "/System/Applications/Safari.app"
    "/System/Applications/Finder.app"
    "/System/Applications/Messages.app"
    "/System/Applications/FaceTime.app"
    "/System/Applications/System Settings.app"
    "/System/Applications/Phone.app"         # iPhone Mirror
    "/System/Applications/Notes.app"          # Notes
    "/System/Applications/Reminders.app"      # Reminders
    "/System/Applications/App Store.app"      # App Store
)

for app in "${essential_apps[@]}"; do
    dockutil --add "$app" --no-restart
done

# Add Applications folder (list view, display as folder)
dockutil --add /Applications --view list --display folder --no-restart

# Add Downloads folder (fan view, display as folder)
dockutil --add ~/Downloads --view fan --display folder --no-restart

# Restart Dock to apply changes
killall Dock

echo "Dock updated successfully!"
