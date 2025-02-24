#!/bin/bash

# Define variables
GROUP_NAME="ivolve"
USER_NAME="ivolveadmin"
SUDOERS_FILE="/etc/sudoers.d/ivolve"

# Create the group if it doesn't exist
if ! getent group $GROUP_NAME > /dev/null; then
    sudo groupadd $GROUP_NAME
    echo "Group '$GROUP_NAME' created."
else
    echo "Group '$GROUP_NAME' already exists."
fi

# Create the user and assign to the group
if ! id -u $USER_NAME > /dev/null 2>&1; then
    sudo useradd -m -s /bin/bash -g $GROUP_NAME $USER_NAME
    echo "User '$USER_NAME' created and assigned to group '$GROUP_NAME'."
else
    echo "User '$USER_NAME' already exists."
fi

# Set password for the user
PASSWORD="123"
echo "$USER_NAME:$PASSWORD" | sudo chpasswd
echo "Password set for '$USER_NAME'. Save this securely: $PASSWORD"

# Grant sudo privileges without password for installing Nginx
if [ ! -f "$SUDOERS_FILE" ]; then
    echo "%$GROUP_NAME ALL=(ALL) NOPASSWD: /usr/bin/apt install nginx -y" | sudo tee $SUDOERS_FILE > /dev/null
    echo "Sudo permissions set for group '$GROUP_NAME' to install Nginx without password."
else
    echo "Sudoers file already exists. No changes made."
fi

# Verify and display success message
echo "Setup complete. You can now log in as '$USER_NAME' and install Nginx with sudo access without a password."
echo "Test with: su - $USER_NAME && sudo apt install nginx -y"

## or run lab.sh

## Steps to Execute the Script

### 1. Save the Script
If you haven’t already, create a script file named `lab.sh`:
```bash
vim setup_ivolveadmin.sh
```

### 2. Grant Execute Permissions
Run the following command to make the script executable:
```bash
chmod +x lab.sh
```

### 3. Execute the Script with Root Privileges
Run the script using the following command:
```bash
sudo ./lab.sh
```

