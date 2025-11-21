# Pre-Installation Guide: Backup & Clean Install for macOS Tahoe

Complete guide for backing up your existing Mac and performing a clean installation of macOS Tahoe.

## Table of Contents

1. [Backup Your Data](#backup-your-data)
2. [Backup Configuration Files](#backup-configuration-files)
3. [Prepare for Clean Install](#prepare-for-clean-install)
4. [Perform Clean Installation](#perform-clean-installation)
5. [Verification](#verification)

---

## 📦 Backup Your Data

### Step 1: Create External Backup

Before wiping your Mac, create a complete backup on an external drive.

**Using Time Machine (Recommended):**

1. Connect an external hard drive (500GB+ recommended)
2. Open System Settings
3. Click "General" → "Time Machine" (or search for "Time Machine")
4. Click "Add Backup Disk" and select your external drive
5. Click "Use as Backup Disk"
6. Wait for backup to complete (may take several hours depending on data size)

**What Gets Backed Up:**
- All files and folders
- Applications
- System settings
- Accounts and preferences

### Step 2: Backup Important Documents

Ensure critical files are safely backed up:

```bash
# Manual backup to external drive
# Replace /Volumes/ExternalDrive with your drive's name
cp -R ~/Documents /Volumes/ExternalDrive/backup/
cp -R ~/Desktop /Volumes/ExternalDrive/backup/
cp -R ~/Downloads /Volumes/ExternalDrive/backup/
```

### Step 3: Backup Cloud Sync Settings

Document any cloud services you use:
- iCloud Drive sync location
- Dropbox, Google Drive, OneDrive settings
- Other cloud storage accounts

---

## ⚙️ Backup Configuration Files

### Step 1: Create Backup Directory Structure

```bash
mkdir -p ~/Developer/Mac-Setting/Configs
mkdir -p ~/Developer/Mac-Setting/Configs/zsh
mkdir -p ~/Developer/Mac-Setting/Configs/oh-my-zsh/custom
mkdir -p ~/Developer/Mac-Setting/Configs/terminal
mkdir -p ~/Developer/Mac-Setting/Configs/terminal/vscode
mkdir -p ~/Developer/Mac-Setting/Configs/apps
```

### Step 2: Backup ZSH Configuration

```bash
# Backup all ZSH config files
cp ~/.zshrc ~/Developer/Mac-Setting/Configs/zsh/ 2>/dev/null
cp ~/.zprofile ~/Developer/Mac-Setting/Configs/zsh/ 2>/dev/null
cp ~/.zshenv ~/Developer/Mac-Setting/Configs/zsh/ 2>/dev/null
cp ~/.zlogin ~/Developer/Mac-Setting/Configs/zsh/ 2>/dev/null
cp ~/.zlogout ~/Developer/Mac-Setting/Configs/zsh/ 2>/dev/null
```

### Step 3: Backup Oh My Zsh Customizations

```bash
# Backup custom themes and plugins
if [ -d ~/.oh-my-zsh/custom ]; then
    cp -R ~/.oh-my-zsh/custom/* ~/Developer/Mac-Setting/Configs/oh-my-zsh/custom/
fi
```

### Step 4: Backup Terminal & iTerm2 Preferences

```bash
# Backup Terminal.app preferences
cp ~/Library/Preferences/com.apple.Terminal.plist \
   ~/Developer/Mac-Setting/Configs/terminal/ 2>/dev/null

# Backup iTerm2 preferences (if installed)
if [ -f ~/Library/Preferences/com.googlecode.iterm2.plist ]; then
    cp ~/Library/Preferences/com.googlecode.iterm2.plist \
       ~/Developer/Mac-Setting/Configs/terminal/
fi
```

### Step 5: Backup VS Code Settings

```bash
# Backup VS Code user settings
if [ -d "$HOME/Library/Application Support/Code/User" ]; then
    mkdir -p ~/Developer/Mac-Setting/Configs/apps/vscode
    cp "$HOME/Library/Application Support/Code/User/settings.json" \
       ~/Developer/Mac-Setting/Configs/apps/vscode/ 2>/dev/null
    cp "$HOME/Library/Application Support/Code/User/keybindings.json" \
       ~/Developer/Mac-Setting/Configs/apps/vscode/ 2>/dev/null
fi
```

### Step 6: Backup Homebrew Packages List

```bash
# Export list of installed Homebrew packages
if command -v brew &> /dev/null; then
    brew bundle dump --file=~/Developer/Mac-Setting/Configs/Brewfile
    echo "✅ Homebrew packages saved to Brewfile"
fi
```

### Step 7: Create Backup Metadata

```bash
# Create metadata file with system information
cat > ~/Developer/Mac-Setting/Configs/backup-metadata.txt << EOF
# Backup Information

**Backup Date:** $(date)
**macOS Version:** $(sw_vers -productVersion)
**System Model:** $(system_profiler SPHardwareDataType | grep "Model Identifier" | awk '{print $3}')
**Processor:** $(system_profiler SPHardwareDataType | grep "Chip" | awk '{print $3, $4, $5}')
**RAM:** $(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2, $3}')
**Hostname:** $(hostname)
**Shell:** $SHELL
**ZSH Version:** $(zsh --version)
**Oh My ZSH:** $(if [ -d ~/.oh-my-zsh ]; then echo "Installed"; else echo "Not installed"; fi)
**Oh My ZSH Theme:** $(if [ -f ~/.zshrc ]; then grep "^ZSH_THEME=" ~/.zshrc | cut -d'"' -f2; else echo "N/A"; fi)
**Homebrew:** $(if command -v brew &> /dev/null; then brew --version | head -1; else echo "Not installed"; fi)
**Git:** $(git --version 2>/dev/null || echo "Not installed")
**Python:** $(python3 --version 2>/dev/null || echo "Not installed")
**Docker:** $(docker --version 2>/dev/null || echo "Not installed")

## Installed Applications
EOF

# Add list of installed apps
if command -v brew &> /dev/null; then
    echo "### Homebrew Formulae" >> ~/Developer/Mac-Setting/Configs/backup-metadata.txt
    brew list >> ~/Developer/Mac-Setting/Configs/backup-metadata.txt
    echo "" >> ~/Developer/Mac-Setting/Configs/backup-metadata.txt
    echo "### Homebrew Casks" >> ~/Developer/Mac-Setting/Configs/backup-metadata.txt
    brew list --cask >> ~/Developer/Mac-Setting/Configs/backup-metadata.txt
fi

echo "✅ Backup metadata created"
```

---

## 🔐 Prepare for Clean Installation

### Step 1: Sign Out of Apple Services

These steps are essential before erasing:

1. **Sign out of iCloud:**
   - Open System Settings
   - Click your Apple ID at the top (or "Sign in" if not logged in)
   - Scroll down and click "Sign Out"
   - When prompted about Find My, choose "Keep on This Mac" or remove device from iCloud
   - Deselect iCloud Drive if prompted

2. **Turn Off Find My Mac:**
   - System Settings → Apple ID → iCloud
   - Toggle off "Find My Mac"
   - You may be asked to enter your Apple ID password

3. **Sign Out of Messages:**
   - Open Messages app
   - Menu bar → Messages → Settings
   - Click "Accounts"
   - Select your account and click "Sign Out"

4. **Deauthorize Music/iTunes:**
   - Open Music (or iTunes if using older OS)
   - Menu bar → Account → Authorizations → Deauthorize This Computer
   - Enter your Apple ID credentials

5. **Sign Out of Other Apps:**
   - Slack
   - Microsoft Office (if installed)
   - Any other subscription services

### Step 2: Document Important Information

Save these details somewhere safe (not on the Mac you're erasing):

```
My Mac Setup Information:
- Apple ID: _______________
- iCloud backup status: _______________
- Installed apps to reinstall: _______________
- Custom shortcuts/automation: _______________
- Wifi networks and passwords: _______________
- Mounted network drives: _______________
```

### Step 3: Transfer Backup to External Storage

```bash
# Copy your backup repo to external drive
# Replace /Volumes/ExternalDrive with your actual drive name
cp -R ~/Developer/Mac-Setting /Volumes/ExternalDrive/

echo "✅ Backup copied to external drive"
```

### Step 4: Verify Backups

```bash
# Check that Time Machine backup is complete
diskutil info /Volumes/ExternalDrive | grep "Mounted"

# Verify backup repo
ls -la /Volumes/ExternalDrive/Mac-Setting/

# List files
ls -la /Volumes/ExternalDrive/Mac-Setting/Configs/
```

---

## 💻 Perform Clean Installation

### Step 1: Back Up Your Current Setup (This Repo)

Push this repo to GitHub before erasing:

```bash
cd ~/Developer/Mac-Setting

# Add all changes
git add -A

# Commit your custom configurations
git commit -m "Backup config before clean install"

# Push to remote
git push origin main
```

### Step 2: Restart in Recovery Mode

1. Shut down your Mac
2. Power it on and immediately press and hold **Command (⌘) + R**
3. Keep holding until you see:
   - Apple logo, OR
   - A spinning globe, OR
   - "Recovery Mode" text
4. Release the keys when you see one of these signs
5. Wait for Recovery Mode to load (may take a few minutes)

### Step 3: Erase Your Drive

In Recovery Mode:

1. Click "Utilities" in menu bar
2. Select "Disk Utility"
3. In left sidebar, select "Macintosh HD" (your main drive)
4. Click "Erase" button at top
5. Set options:
   - **Name:** Macintosh HD
   - **Format:** APFS (for Tahoe)
   - **Scheme:** GUID Partition Map
6. Click "Erase"
7. If prompted about deleting data, confirm
8. Wait for erase to complete
9. If you have additional volumes, repeat for each one
10. Close Disk Utility

### Step 4: Install macOS Tahoe

Back in Recovery Mode:

1. Click "Utilities" → "Reinstall macOS" (or similar)
2. Click "Continue"
3. Accept license agreement
4. Select "Macintosh HD" as installation destination
5. Click "Install"
6. **Let it complete.** Your Mac may restart multiple times. Do NOT interrupt.
7. Installation typically takes 20-40 minutes

### Step 5: Complete Setup Assistant

After installation:

1. Mac restarts and shows "Welcome" or Setup Assistant
2. Choose language
3. Select keyboard layout
4. Choose WiFi network and enter password
5. Sign in with Apple ID (optional, but recommended)
6. Create user account with your name
7. Choose to restore from backup or set up as new Mac

**Option A - Restore from Time Machine:**
- Choose "Restore from Time Machine backup"
- Select your external drive
- Select the most recent backup
- Let it restore (will take time depending on data size)

**Option B - Set up as New Mac:**
- Skip restoration
- Start fresh
- Note: You'll need to restore application data manually later

---

## ✅ Verification

### After Clean Install Completes

```bash
# Open Terminal and verify macOS version
sw_vers

# Should show something like:
# ProductName:        macOS
# ProductVersion:     14.x
# BuildVersion:       XXXX
```

### Verify Your Mac is Ready for Setup Scripts

```bash
# Check for internet connection
ping -c 1 google.com

# Check for Terminal access
echo "Terminal works! Ready for Phase 1 setup."
```

### Next Steps

Once clean install is complete:

1. **If you restored from backup:**
   - Applications and settings are already restored
   - You can proceed directly to Phase 1

2. **If you set up as new:**
   - Your Mac is clean and fresh
   - Download and clone the Mac-Setting repo
   - Run Phase 1 bootstrap script

Both scenarios work. You'll proceed with the same Phase 1 script from the main [README.md](README.md).

---

## 🆘 Troubleshooting Clean Install

### "Recovery Mode won't load"
- Try Command+R for standard recovery
- Try Command+Option+R for internet recovery (downloads OS from Apple)
- Try Command+Shift+Option+R for latest compatible OS

### "Erase fails with error"
- Restart and try again
- Ensure external drives are disconnected
- Try using Option+Cmd+P+R to reset SMC (press at startup)

### "Installation seems stuck"
- Give it 30-60 minutes to complete
- Don't close the screen or interrupt power
- It's normal for multiple restarts during installation

### "Won't boot after installation"
- Try recovery mode again
- Verify disk wasn't corrupted (Disk Utility → First Aid)
- Try creating bootable USB installer instead

---

## 📚 References

- [Apple: Reinstall macOS](https://support.apple.com/en-us/HT204904)
- [Recovery Mode Information](https://support.apple.com/en-us/HT201314)
- [macOS Tahoe Support](https://support.apple.com/)

---

**Ready to proceed?** After your clean install is complete, start with the main [README.md](README.md) and run Phase 1!
