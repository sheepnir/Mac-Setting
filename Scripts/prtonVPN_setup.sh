#!/bin/bash

# Function to select ProtonVPN account
select_account() {
    echo "Please select the ProtonVPN account you want to use:"
    accounts=($(op item list --categories Login --tags ProtonVPN --format json | jq -r '.[].title'))
    select account in "${accounts[@]}"; do
        if [ -n "$account" ]; then
            echo "You selected $account"
            return
        else
            echo "Invalid selection. Please try again."
        fi
    done
}

# Call the function to select an account
select_account

# Retrieve ProtonVPN credentials from 1Password
echo "Retrieving ProtonVPN credentials from 1Password..."
PROTONVPN_USERNAME=$(op item get "$account" --format json | jq -r '.fields[] | select(.label == "username").value')
PROTONVPN_PASSWORD=$(op item get "$account" --format json | jq -r '.fields[] | select(.label == "password").value')
PROTONVPN_OTP=$(op item get "$account" --otp)

# Display the username and OTP (but not the password)
echo "Username: $PROTONVPN_USERNAME"
echo "One-Time Passcode: $PROTONVPN_OTP"
echo "Password has been retrieved (not displayed for security reasons)"

# Prompt user to open ProtonVPN and use the credentials
echo "Please open the ProtonVPN application and use the above credentials to log in."
echo "Press any key to open ProtonVPN..."
read -n 1 -s

# Open ProtonVPN
open -a ProtonVPN

echo "ProtonVPN has been opened. Please use the retrieved credentials to log in."
echo "Use the displayed One-Time Passcode if prompted for 2FA."