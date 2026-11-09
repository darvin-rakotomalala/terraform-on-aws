# vpc/variables.tf
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "18.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDR blocks for subnets"
  type        = list(string)
  default     = ["18.0.1.0/24", "18.0.2.0/24"]
}
