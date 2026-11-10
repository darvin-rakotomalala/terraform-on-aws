/*EC2 variables can be used to store values such as the AMI ID, instance type, and VPC ID of an 
EC2 instance. These values in our Terraform code are used to create and configure EC2 instances. */

variable "ami" {
  description = "AMI of ec2 instance"
  type        = string
  default     = "ami-020cba7c55df1f615"
}

# Launch Template and ASG Variables
variable "instance_type" {
  description = "launch template EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "aws_key_pair" {
  type    = string
  default = "my-key-pair"
}

# This user data variable indicates that the script configures Apache on a server.
variable "ec2_user_data" {
  description = "variable indicates that the script configures Apache on a server"
  type        = string
  default     = <<EOF
        #!/bin/bash
        # Install Apache on Ubuntu
        sudo apt update -y
        sudo apt install -y apache2
        sudo cat > /var/www/html/index.html << EOF
        <html>
        <head>
        <title>Demo VPC-ASG-LB</title>
        </head>
        <body>
        <p> Welcome to AWS EC2 Auto-Scaling Group for High Availability using Terraform!</p>
        <br>
        </h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>
        </body>
        </html>
    EOF
}

/*This VPC can then be used to deploy resources that need to be accessible from the internet or from other resources in the VPC.
This variable defines the CIDR block for the VPC. The default value is 10.0.0.0/16.
*/

# VPC Variables
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "18.10.0.0/16"
}

# These Public subnets are used for resources that need to be accessible from the internet
variable "public_subnet_cidr" {
  description = "Public Subnet cidr block"
  type        = list(string)
  default     = ["18.10.0.0/24", "18.10.2.0/24"]
}

# These Private subnets can be used to deploy resources that do not need to be accessible from the internet.
variable "private_subnet_cidr" {
  description = "Private Subnet cidr block"
  type        = list(string)
  default     = ["18.10.3.0/24", "18.10.4.0/24"]
}

# This is a Environement variable 
variable "environment" {
  description = "Environment name for deployment"
  type        = string
  default     = "demo"
}

# This is a Region Variable
variable "aws_region" {
  description = "AWS region name"
  type        = string
  default     = "us-east-1"
}
