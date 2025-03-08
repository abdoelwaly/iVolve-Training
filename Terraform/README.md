# Lab 16: Multi-Tier Application Deployment with Terraform

## Overview
• Create a VPC manually.
• Make Terraform manage this VPC.
• Implement the below diagram with Terraform.
• Use local provisioner to write the EC2 IP in a file called ec2-ip.txt.

## Infrastructure Components

### 1. **VPC & Subnets**
- A **VPC** (`10.0.0.0/16`) named `ivolveVPC`.
- ![Import-VPC](https://github.com/abdoelwaly/iVolve-Training/blob/87beffd6a195ecb784af279cb8d28f3ebb296a10/Terraform/lab16/assets/Screenshot%202025-03-05%20123704.png) 
- **Public Subnet** (`10.0.1.0/24`) in `us-east-1a` with public IP auto-assignment.
- **Private Subnet-A** (`10.0.2.0/24`) in `us-east-1a` for internal resources.
- **Private Subnet-B** (`10.0.3.0/24`) in `us-east-1b` for high availability.

### 2. **Internet Gateway & Route Table**
- **Internet Gateway** for public internet access.
- **Route Table** to direct traffic from the public subnet to the Internet Gateway.

### 3. **Security Groups**
- **EC2 Security Group**: Allows inbound SSH (22) and HTTP (80) traffic from anywhere.
- **RDS Security Group**: Restricts MySQL (3306) access to only the EC2 instance.

### 4. **Compute & Database Resources**
- **EC2 Instance** (Amazon Linux, `t2.micro`) in the public subnet for hosting the application.
- **RDS MySQL Database** (`db.t3.micro`) in private subnets for data storage.

## Outputs
After deployment, you can check the following outputs:
- **EC2 Public IP:** Stored in `ec2-ip.txt` for SSH and HTTP access.
- **RDS Instance Endpoint:** Available for database connections.

## Architecture Diagram
To visualize the architecture, please refer to the linked diagram:
- ![AWS Infrastructure Diagram](https://github.com/abdoelwaly/iVolve-Training/blob/87beffd6a195ecb784af279cb8d28f3ebb296a10/Terraform/lab16/assets/arch.jpg) 

Additionally, include screenshots of the AWS console showing:
- VPC and Subnet setup.
- Security Groups configurations.
- EC2 instance details.
- RDS instance details.

## Deployment Instructions
1. Install Terraform.
2. Configure AWS CLI credentials.
3. Run the following Terraform commands:
   ```sh
   terraform init
   terraform plan
   terraform apply -auto-approve
   ```
![output](https://github.com/abdoelwaly/iVolve-Training/blob/87beffd6a195ecb784af279cb8d28f3ebb296a10/Terraform/lab16/assets/Screenshot%202025-03-05%20134619.png)

4. Retrieve the EC2 instance IP from `ec2-ip.txt` and access the server.
5. Connect to the RDS database using the endpoint and credentials.

## Cleanup
To delete the infrastructure:
```sh
terraform destroy -auto-approve
```



