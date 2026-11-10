# Variables for Autoscaling
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "asg_min_size" {
  type    = number
  default = 2
}

variable "asg_desired_size" {
  type    = number
  default = 2
}

variable "asg_max_size" {
  type    = number
  default = 4
}

variable "aws_key_pair" {
  type    = string
  default = "my-key-pair"
}

# Variables for VPC
variable "vpc_cidr" {
  default     = "18.0.0.0/16"
  description = "CIDR block of the vpc"
}
