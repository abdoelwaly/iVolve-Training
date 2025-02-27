# Lab 10: Set up Ansible dynamic inventories to automatically discover and manage infrastructure. Use Ansible Galaxy role to install Apache.
## Overview
Dynamic inventories allow Ansible to automatically discover and manage infrastructure by querying an external source, such as cloud providers or configuration management databases. Ansible Galaxy roles are reusable units of Ansible content that can simplify playbook tasks. This lab will guide you through creating a dynamic inventory script and using an Ansible Galaxy role to install Apache on managed hosts. 

### Step 1: Configure Dynamic Inventory
Dynamic inventories can be configured using a script or plugin. For cloud environments, such as AWS, you can use the ec2 plugin.
#### 1- Install Required Collections
```
ansible-galaxy collection install amazon.aws
```
#### 2- Configure the ansible.cfg File Ensure your ansible.cfg file points to the dynamic inventory script
```
[defaults]
inventory = ./aws_ec2.yml 
```
#### 3- Create a Dynamic Inventory Script Create a dynamic_inventory.yml file:
```
plugin: amazon.aws.ec2
regions:
  - us-east-1
filters:
  instance-state-name: running
```
This script uses the ec2 plugin to list running instances in the us-east-1 region. Make sure you have the necessary AWS credentials set up on your system, or use aws configure to set them up.
### Step 2: Use Ansible Galaxy Role to Install Apache
#### 1- Install the Apache Role Use Ansible Galaxy to install a pre-existing role for Apache:
```
ansible-galaxy install geerlingguy.apache
```
#### 2- Create a Playbook to Install Apache Create a install_apache.yml file to use the Apache role:
```
- name: Install Apache on all managed nodes
  hosts: all
  become: yes
  roles:
    - geerlingguy.apache
```
### Step 3: Run the Playbook
####  Execute the playbook with the following command:
```
ansible-playbook install_apache.yml
```
## Expected Output
When you run the ansible-playbook command, you should see output similar to this:
```
PLAY [Install Apache on all managed nodes] *************************************

TASK [Gathering Facts] *********************************************************
ok: [instance-1]
ok: [instance-2]

TASK [geerlingguy.apache : Ensure Apache is installed] ************************
ok: [instance-1]
ok: [instance-2]

TASK [geerlingguy.apache : Ensure Apache is started and enabled] ****************
ok: [instance-1]
ok: [instance-2]

PLAY RECAP *********************************************************************
instance-1                  : ok=3    changed=0    unreachable=0    failed=0   
instance-2                  : ok=3    changed=0    unreachable=0    failed=0   
```
