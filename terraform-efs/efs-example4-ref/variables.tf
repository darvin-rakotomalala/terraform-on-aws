variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for mount targets"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security group IDs allowed to access EFS"
  type        = list(string)
}
