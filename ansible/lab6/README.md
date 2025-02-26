# Lab 7: Install and configure Ansible Automation Platform on control nodes, create inventories of a managed host, and then perform ad-hoc commands to check functionality.
## Overview: Ansible Automation Platform Setup
In this lab, you will set up Ansible Automation Platform on a control node, configure an inventory of managed hosts, and use ad-hoc commands to verify connectivity and functionality. Ansible simplifies IT automation, allowing you to manage configurations, deploy applications, and perform ad-hoc tasks efficiently.
## Prerequisites
(python is must )
1- Ensure Python is installed on the control node:
```
python3 --version
```
2- Update the system package manager:
```
sudo apt update  # For Ubuntu/Debian
```
3- Install pip (Python package manager):
```
sudo apt install python3-pip  # For Ubuntu/Debian
```
4- Ensure passwordless SSH access is configured between the control node and managed hosts. If not, refer to the SSH configuration lab.
## Step By Step 
### Step 1: Install Ansible on the Control Node
#### 1- On Ubuntu/Debian
```
sudo apt install ansible -y
```
#### 2- Verify the installation:
```
ansible --version
```
### Step 2: Configure SSH Access to Managed Hosts
#### 1- Generate an SSH key (if not already created):
```
ssh-keygen -t rsa -b 2048
```
#### 2- Copy the public key to the managed hosts:
```
ssh-copy-id server [a:d]
```
#### 3- Test SSH access:
```
ssh servera
```
### Step 3: Create an Ansible Inventory File
#### 1- Create a directory for Ansible files:
```
mkdir ~/ansible
cd ~/ansible
```
#### 2- Create an inventory file:
```
nano inventory
```
Example content for the inventory file:
```
[db_servers]
serverc.lab.example.com
serverd.lab.example.com

[web_servers]
servera.lab.example.com
serverb.lab.example.com


[myself]
workstation.lab.example.com
```
### Step 4: Test Ansible Configuration
#### 1- Ping the managed hosts:
```
ansible all -i inventory -m ping
```
![output](https://github.com/abdoelwaly/iVolve-Training/blob/fa52f1765275ba5c050aa51e118165b703680db2/ansible/lab6/Screenshot%202025-02-26%20105246.png)

#### 2- Run an ad-hoc command to check uptime:
```
ansible all -i inventory -m command -a "uptime"
```
### Step 5: Perform Ad-Hoc Tasks
#### 1- List all files in /etc on all managed hosts:
```
ansible all -i inventory -m command -a "ls /etc"
```
#### 2- Check disk usage:
```
ansible all -i inventory -m command -a "df -h"
```

