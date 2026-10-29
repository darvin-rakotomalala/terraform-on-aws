variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "18.0.0.0/16"
}

variable "access_cidr" {
  default = "0.0.0.0/0"
}

variable "subnet_count" {
  default = 2
}

variable "public_cidrs" {
  type    = list(any)
  default = ["18.0.1.0/24", "18.0.2.0/24"]
}

variable "private_cidrs" {
  type    = list(any)
  default = ["18.0.3.0/24", "18.0.4.0/24"]
}

variable "availability_zone" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}
