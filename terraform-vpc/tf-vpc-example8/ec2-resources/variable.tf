variable "ami_id" {
  default = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}
