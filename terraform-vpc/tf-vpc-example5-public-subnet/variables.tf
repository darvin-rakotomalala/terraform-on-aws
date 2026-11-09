# Setup AWS Region
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

# Setup Availability Zone
variable "az_1a" {
  type        = string
  description = "Availability Zone used by subnet"
  default     = "us-east-1a"
}

# Setup Default Route
variable "default_route" {
  type        = string
  description = "Default Route from and to internet"
  default     = "0.0.0.0/0"
}
