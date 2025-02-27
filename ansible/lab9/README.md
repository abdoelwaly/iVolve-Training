# Lab 9: Organize Ansible playbooks using roles. Create an Ansible role for installing Jenkins, docker, openshift CLI ‘OC’.

## Setup Instructions
### Step 1: Create Project Directory
```sh
mkdir ansible-roles-lab
cd ansible-roles-lab
ansible-galaxy init jenkins_docker_oc
```

### Step 2: Define Installation Tasks
Modify `tasks/main.yml` to install prerequisites, add repositories, install Jenkins, Docker, and OpenShift CLI.

### Step 3: Configure Variables
Modify `defaults/main.yml` to define version control and installation paths.
```yaml
docker_version: "20.10.8"
jenkins_version: "latest"
oc_url: "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz"
```

### Step 4: Create a Playbook to Call the Role
Create `play.yml` in the root directory:
```yaml
---
- name: install packages
  hosts: all 
  become: true
  roles:
    - role: role/Jenkins   
    - role: role/Docker
    - role: role/Openshift
```

### Step 5: Run the Playbook
```sh
ansible-playbook play.yml --check  # Dry run
ansible-playbook play.yml          # Execute installation
```
![output](https://github.com/abdoelwaly/iVolve-Training/blob/b98c55dfd932133b865a0b7de9436f9d372e4582/ansible/lab9/Screenshot%202025-02-27%20105418.png)

## Validation
### 1. Check Jenkins Status
```sh
systemctl status jenkins
```

### 2. Verify Docker Installation
```sh
docker --version
```

### 3. Check OpenShift CLI Version
```sh
oc version
```



