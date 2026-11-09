variable "key_pair" {
  default = "my-key-pair"
}

variable "ami_id" {
  default = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
}

variable "instance_type" {
  default = "t2.micro"
}

variable "region" {
  default = "us-east-1"
}
