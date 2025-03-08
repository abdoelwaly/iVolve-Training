# Lab 17: Remote Backend and LifeCycles Rules

## Overview
This lab focuses on implementing infrastructure using Terraform while integrating key concepts such as remote state storage, lifecycle rules, and monitoring. The setup includes an EC2 instance running NGINX, monitored via CloudWatch, with alerts sent via SNS.

## Objectives
- Implement the architecture as per the provided diagram.
- Install **NGINX** on an EC2 instance using **user data**.
- Store Terraform **state file in a remote backend (S3)**.
- Apply the **create_before_destroy** lifecycle rule on the EC2 instance.
- Compare different lifecycle rules.

## Architecture Diagram
Refer to the attached diagram:
![Architecture Diagram](image.png)

## Infrastructure Components
### 1. **VPC & Subnet**
- **VPC:** (`10.0.0.0/16`)
- **Subnet:** (`10.0.0.0/24`) for hosting the EC2 instance.

### 2. **EC2 Instance (NGINX Server)**
- **Amazon Linux 2** AMI.
- **User Data Script** to install NGINX on launch.
- **Lifecycle Rule:** `create_before_destroy` to ensure zero downtime.

### 3. **Security Group**
- Allows **HTTP (80)** and **SSH (22)** traffic.

### 4. **Internet Gateway & Route Table**
- **Route Table Rule:** Allows internet access via **IGW**.

### 5. **Remote State Storage (S3)**
- Terraform state stored remotely in **Amazon S3** for collaboration and consistency.

### 6. **Monitoring & Alerts**
- **CloudWatch:** Monitors CPU utilization.
- **SNS Topic:** Sends alerts when CPU usage exceeds **70%**.
- **Email Notification:** Alerts are sent to Gmail.

## Terraform Implementation
### 1. **Initialize Terraform**
```sh
terraform init
```
### 2. **Apply Terraform Configuration**
```sh
terraform apply -auto-approve
```
### 3. **Verify Lifecycle Rule**
- Modify instance parameters and rerun `terraform apply`.
- Confirm that the old instance is replaced **after** the new one is created.

### 4. **Cleanup (Destroy Infrastructure)**
```sh
terraform destroy -auto-approve
```




