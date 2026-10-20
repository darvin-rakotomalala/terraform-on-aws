#---variable/root

variable "name" {
  type    = string
  default = "cloudwithdarvin.com"
}

variable "bucketName" {
  type    = string
  default = "www.cloudwithdarvin.com"
}

variable "region_number" {
  default = {
    us-east-2 = 1
    us-east-1 = 2
  }
}

variable "az_number" {
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
  }
}
