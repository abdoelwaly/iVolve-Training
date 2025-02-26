# Lab 7: Ansible Playbooks for Web Server Configuration Write an Ansible playbook to automate the configuration of a web server.


### Step 1: Define Your Inventory
#### 1- Create an inventory file (if not already done):
```
vim ~/ansible/inventory
```

### Step 2: Create the Playbook

#### 1- Create a playbook file:
```
vim site.yml
```
#### 2- Add the following playbook content:
```
---
- name: Install and start Apache HTTPD
  hosts: web
  tasks:
    - name: Ensure httpd package is present
      ansible.builtin.dnf:
        name: httpd
        state: present

    - name: Correct index.html is present
      ansible.builtin.copy:
        src: files/index.html
        dest: /var/www/html/index.html

    - name: Ensure httpd is started
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: true
```
### Step 3: Run the Playbook
#### 1- Execute the playbook:
```
ansible-navigtor run -m stdout site.yml
```

![output](https://github.com/abdoelwaly/iVolve-Training/blob/fa52f1765275ba5c050aa51e118165b703680db2/ansible/lab7/Screenshot%202025-02-26%20102249.png)









