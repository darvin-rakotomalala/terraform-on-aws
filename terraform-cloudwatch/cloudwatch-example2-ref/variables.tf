# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "DEMO-CW"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "DEV"
}

variable "alert_email" {
  description = "Email address for alerts"
  type        = string
  default     = "darvintojo@gmail.com"
}

variable "api_name" {
  description = "API name for application monitoring"
  type        = string
  default     = "api.cloudwithdarvin.com"
}

variable "api_stage" {
  description = "API stage application monitoring"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "18.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
  default     = "18.0.1.0/24"
}
