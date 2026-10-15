variable "lb_name" {
  type    = string
  default = "tf-lb"
}

variable "nlb_name" {
  type    = string
  default = "tf-nlb"
}

variable "ec2_ami" {
  default     = "ami-020cba7c55df1f615"
  description = "Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)"
}
