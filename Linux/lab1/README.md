# Lab 1: User and Group Management

## Objective
Create a new group named ivolve and a new user assigned to this group with a secure password. Configure the user’s permissions to allow installing Nginx with elevated privileges using the sudo tool (run sudo command for installing nginx without password).

## Steps to Configure

### 1. Create a New Group
Run the following command to create a new group named `ivolve`:
```bash
sudo groupadd ivolve
```

### 2. Create a New User (`ivolveadmin`) and Assign to the Group
Execute the command below to create the user and assign it to the `ivolve` group:
```bash
sudo useradd -m -s /bin/bash -g ivolve ivolveadmin
```

### 3. Set a Secure Password for `ivolveadmin`
You can manually set a password by running:
```bash
sudo passwd ivolveadmin
```

### 4. Grant `sudo` Privileges Without Password for Installing Nginx
To allow `ivolveadmin` to install Nginx without entering a password:

1. Open a new sudoers file:
   ```bash
   sudo visudo -f /etc/sudoers.d/ivolve
   ```
2. Add the following line to the file:
   ```
   %ivolve ALL=(ALL) NOPASSWD: /usr/bin/apt install nginx -y
   ```

### 5. Verify Configuration
Switch to the newly created user:
```bash
su - ivolveadmin
```

Run the following command to test if the user can install Nginx without a password:
```bash
sudo apt install nginx -y
```
If configured correctly, Nginx should install without prompting for a password.


### or you can run lab Script.

## Steps to Execute the Script


### 1. Grant Execute Permissions
Run the following command to make the script executable:
```bash
chmod +x lab.sh
```

### 2. Execute the Script with Root Privileges
Run the script using the following command:
```bash
sudo ./lab.sh
```

