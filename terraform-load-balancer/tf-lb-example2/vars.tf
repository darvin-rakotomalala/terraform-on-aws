variable "vpc_cidr" {
  default     = "18.0.0.0/16"
  description = "CIDR block of the vpc"
}

variable "subnet_a_cidr" {
  default     = "18.0.18.0/24"
  description = "CIDR block for Public Subnet"
}

variable "subnet_b_cidr" {
  default     = "18.0.4.0/24"
  description = "CIDR block for Public Subnet"
}

variable "subnet_c_cidr" {
  default     = "18.0.93.0/24"
  description = "CIDR block for Private Subnet"
}

variable "subnet_d_cidr" {
  default     = "18.0.25.0/24"
  description = "CIDR block for Private Subnet"
}

variable "ec2_ami" {
  default     = "ami-020cba7c55df1f615"
  description = "Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)"
}
