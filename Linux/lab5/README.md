# SSH Configuration Guide

## Objective
This guide explains how to generate SSH keys, enable passwordless authentication for a remote server (`servera`), and configure SSH to allow a simplified connection using the alias `ivolve`.

---

## 1. Generate SSH Key Pair
Run the following command on your local machine to create an SSH key pair:
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
```

---

## 2. Copy Public Key to `servera`
Transfer the public key to `servera` by running:
```bash
ssh-copy-id -i ~/.ssh/ivolve-key.pub servera
```

---

## 3. Configure SSH for Simplified Connection
Edit your SSH configuration file:
```bash
vim ~/.ssh/config
```
Add the following lines:
```ini
Host ivolve
    HostName servera
    User student
    IdentityFile ~/.ssh/id_rsa
```


---

## 4. Test SSH Connection
Now, simply run:
```bash
ssh ivolve
```
This will log you into `servera` without specifying a username, IP, or key.
