variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "SQS-DEMO"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

/*
variable "source_arn" {
  description = "ARN of the source service"
  type        = string
}

variable "allowed_account_arns" {
  description = "List of AWS account ARNs allowed to access the queue"
  type        = list(string)
  default     = []
}
*/
