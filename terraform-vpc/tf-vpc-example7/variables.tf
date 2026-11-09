variable "region" {
  default = "us-east-1"
}

variable "az_1" {
  default = "us-east-1a"
}

variable "az_2" {
  default = "us-east-1b"
}

variable "az_3" {
  default = "us-east-1c"
}

variable "amis" {
  default = {
    us-east-1 = "YOUR_AMI"
  }
}
