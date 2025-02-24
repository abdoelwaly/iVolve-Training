# MySQL Installation and Backup Setup on Ubuntu

## 1. Install MySQL on Ubuntu

### Step 1: Update Package Lists
```bash
sudo apt update
```

### Step 2: Install MySQL Server
```bash
sudo apt install mysql-server -y
```

### Step 3: Start and Enable MySQL Service
```bash
sudo systemctl start mysql
sudo systemctl enable mysql
```

## 2. Secure MySQL Installation
Run the security script to configure MySQL:
```bash
sudo mysql_secure_installation
```
Follow the prompts to:
- Set a root password.
- Remove anonymous users.
- Disable remote root login.
- Remove test databases.

## 3. Create a Backup Script

### Step 1: Create a Backup Directory
```bash
mkdir -p /backup/mysql
```

### Step 2: Create the Backup Script
```bash
sudo nano /backup/mysql_backup.sh
```

### Step 3: Add the Following Script
```bash
#!/bin/bash

# Variables
BACKUP_DIR="/backup/mysql"
DATE=$(date +\%F)
MYSQL_USER="root"
MYSQL_PASSWORD="************"  
MYSQL_DATABASE="ivolvedb"  

# Perform the backup
mysqldump -u $ivolve -p$***** $ivolvedb > $BACKUP_DIR/mysql_backup_$DATE.sql


### Step 4: Make the Script Executable
```bash
sudo chmod +x /backup/mysql_backup.sh
```

## 4. Schedule the Backup Using Cron Job

### Step 1: Open the Cron Configuration
```bash
crontab -e
```

### Step 2: Add the Following Line at the End
This schedules the backup every **Sunday at 5 AM**:
```bash
0 5 * * 0 /backup/mysql_backup.sh
```


## 5. Verify the Cron Job
To check the scheduled cron jobs:
```bash
crontab -l
```

## 6. Restart Cron Service
Ensure the cron service is running:
```bash
sudo systemctl restart cron
```

## Summary
- This setup will back up your MySQL database **every Sunday at 5 AM**.

