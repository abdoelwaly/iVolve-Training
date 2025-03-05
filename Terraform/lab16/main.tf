provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "ivolve_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ivolveVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.ivolve_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.ivolve_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private-Subnet"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.ivolve_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-Subnet-B"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ivolve_vpc.id
  tags = {
    Name = "My-Internet-Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ivolve_vpc.id
  tags = {
    Name = "Public-Route-Table"
  }
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow inbound SSH and HTTP"
  vpc_id      = aws_vpc.ivolve_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}

# RDS Security Group (only allow inbound from EC2 Security Group and MySQL at 3306)
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound MySQL from EC2"
  vpc_id      = aws_vpc.ivolve_vpc.id

  ingress {
    description     = "MySQL from EC2 SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-SG"
  }
}

# Launch the EC2 Instance (Public Subnet)
resource "aws_instance" "web" {
  ami           = "ami-05b10e08d247fb927" #  Amazon Linux AMI
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "IvolveWebServer"
  }

  # Local provisioner to write the public IP to a file named ec2-ip.txt
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2-ip.txt"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "my-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet.id,
    aws_subnet.private_subnet_b.id
  ]

  tags = {
    Name = "DB-Subnet-Group"
  }
}

resource "aws_db_instance" "mydb-rds" {
  identifier             = "mydb-instance"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "mydatabase"
  username               = "admin"
  password               = "SomePassword123!"
  multi_az               = "false"
  publicly_accessible    = "false"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "My-RDS"
  }
}

