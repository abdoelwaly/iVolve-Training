# Terraform Lab: Variables and Loops

## Lab Overview
This lab focuses on implementing AWS infrastructure using Terraform while emphasizing the use of variables and loops to avoid code repetition. The architecture includes:
- A VPC with two subnets.
- An EC2 instance running **Nginx** in the public subnet (installed via remote provisioner).
- An EC2 instance running **Apache** in the private subnet (installed via user data).
- A NAT Gateway to allow outbound internet access from the private subnet.
- An Internet Gateway (IGW) for public internet access.
- Security groups to allow necessary traffic.
- Terraform output to display the public and private IPs of the EC2 instances.

## Architecture Diagram
Refer to the attached diagram:
![Architecture Diagram](https://github.com/abdoelwaly/iVolve-Training/blob/364e1d28aa6e5c765726888dfb0d513540a220a6/Terraform/lab18/assets/Screenshot%202025-03-08%20171616.png)

## Prerequisites
- **AWS Account** with IAM permissions to create EC2, VPC, and other resources.
- **Terraform installed** on your local machine (>= v1.0.0).
- **SSH Key Pair** for EC2 access (either create one locally or use an existing one).
- **AWS CLI configured** with valid credentials.

## Folder Structure
```
terraform-lab/
├── main.tf               # Updated with aws_key_pair and EC2 key_name reference
├── variables.tf          # Remove "key_name" variable if no longer used
├── terraform.tfvars      # Remove "key_name" entry
├── outputs.tf
├── lab18keys             # Private key (keep it secure!)
└── lab18keys.pub         # Public key (uploaded to AWS)
│── README.md            # Documentation
```

## Steps to Deploy

1. **Clone the Repository (If Applicable)**
   ```sh
   git clone <repository-url>
   cd terraform-lab
   ```

2. **Initialize Terraform**
   ```sh
   terraform init
   ```

3. **Validate Configuration**
   ```sh
   terraform validate
   ```

4. **Preview Changes**
   ```sh
   terraform plan
   ```

5. **Apply the Configuration**
   ```sh
   terraform apply -auto-approve
   ```

6. **Retrieve Output Information**
   ```sh
   terraform output
   ```

## Expected Outputs
After deployment, Terraform will output:
- **Public IP** of the Nginx EC2 instance.
- **Private IP** of the Apache EC2 instance.

Refer to the Servers created:
![Servers](https://github.com/abdoelwaly/iVolve-Training/blob/364e1d28aa6e5c765726888dfb0d513540a220a6/Terraform/lab18/assets/Screenshot%202025-03-08%20171240.png)


Refer to the VPC created:
![VPC](https://github.com/abdoelwaly/iVolve-Training/blob/364e1d28aa6e5c765726888dfb0d513540a220a6/Terraform/lab18/assets/Screenshot%202025-03-08%20171340.png)

## Cleanup
To destroy all resources created by Terraform:
```sh
terraform destroy -auto-approve
```



