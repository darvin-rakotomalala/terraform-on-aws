variable "inbound_ec2" {
  type        = list(any)
  default     = [22, 80]
  description = "Inbound port allow on production instance"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
}

variable "key_name" {
  type    = string
  default = "my-key-pair"
}

variable "availability_zone" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  type    = string
  default = "18.0.0.0/16"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "List of all cidr for subnet"
  default     = ["18.0.1.0/24", "18.0.2.0/24"]
}
