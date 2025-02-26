# Lab 8: Ansible Playbook for MySQL Setup

## Overview
This lab demonstrates how to use Ansible to:
1. Install MySQL.
2. Create a database (`ivolve`).
3. Create a user with full privileges on the database.
4. Secure sensitive credentials using Ansible Vault.

## Steps
1. **Prepare the Environment**
   - Configure the inventory file with database server details.

2. **Secure Sensitive Information**
   - Use Ansible Vault to encrypt database credentials in `secrets.yml`.

3. **Write the Ansible Playbook**
   - The `playbook.yml` playbook automates MySQL installation, database creation, and user setup.

![output](https://github.com/abdoelwaly/iVolve-Training/blob/fa52f1765275ba5c050aa51e118165b703680db2/ansible/lab8/Screenshot%202025-02-26%20130915.png)

4. **Run the Playbook**
   - Execute the playbook using Ansible Vault to securely inject credentials.

5. **Validate Configuration**
   - Log in to MySQL and verify the `ivolve` database and user permissions.

## Security Considerations
- Always encrypt sensitive data using Ansible Vault.
- Avoid hardcoding passwords in playbooks.



