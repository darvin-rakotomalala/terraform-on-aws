variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-west-2a", "us-west-2b"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["18.0.1.0/24", "18.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["18.0.4.0/24", "18.0.5.0/24"]
}

variable "desired_capacity" {
  # pilot light: 0, warm stand-by: 1, multi-site active: 2
  default = 0
}
