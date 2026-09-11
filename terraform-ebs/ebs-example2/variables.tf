variable "instance_type" {
  description = "This describes the instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "This describes the ami image"
  type        = string
  default     = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS
}

variable "server_port" {
  description = "Server use this port for http requests"
  type        = number
  default     = 80
}

variable "ssh_port" {
  description = "Describes the ssh port"
  type        = number
  default     = 22
}

variable "availability_zone" {
  default = "us-east-1a"
}
