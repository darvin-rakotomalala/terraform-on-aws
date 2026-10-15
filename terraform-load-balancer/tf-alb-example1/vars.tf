variable "vpc_cidr" {
  default     = "18.0.0.0/16"
  description = "CIDR block of the vpc"
}

variable "subnet1_cidr" {
  default     = "18.0.18.0/24"
  description = "CIDR block for Public Subnet"
}

variable "subnet2_cidr" {
  default     = "18.0.4.0/24"
  description = "CIDR block for Public Subnet"
}

variable "subnet3_cidr" {
  default     = "18.0.93.0/24"
  description = "CIDR block for Private Subnet"
}
