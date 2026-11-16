variable "aws_region" {
  default = "us-east-1"
}

variable "ami" {
  type    = string
  default = "ami-020cba7c55df1f615"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair" {
  type    = string
  default = "my-key-pair"
}

variable "instance_count" {
  default = 2
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

variable "rds_engine" {
  default = "mysql"
}

variable "rds_engine_version" {
  default = "8.4"
}

variable "rds_instance_class" {
  default = "db.t3.micro"
}

variable "rds_name" {
  default = "mydb"
}

variable "rds_username" {
  default = "root"
}

variable "rds_password" {
  default = "root69127"
}

variable "rds_parameter_group_name" {
  default = "default.mysql8.4"
}
