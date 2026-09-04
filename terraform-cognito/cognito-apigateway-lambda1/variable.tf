variable "domain_name" {
  type    = string
  default = "cloudwithdarvin"
}

variable "username" {
  type      = string
  default   = "testUser"
  sensitive = true
}

variable "password" {
  type      = string
  default   = "root@69127"
  sensitive = true
}
