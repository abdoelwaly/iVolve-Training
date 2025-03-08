variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}


variable "private_key_path" {
  description = "Path to the private SSH key"
  type        = string
  default     = "./lab18keys.pem"
}

variable "ssh_user" {
  description = "SSH user for the provisioner"
  type        = string
}