# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "DEMO-SNS"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "email_endpoint" {
  description = "Email endpoint for subscription"
  type        = string
  default     = "darvintojo@gmail.com"
}

variable "allowed_aws_account_ids" {
  description = "List of AWS account IDs allowed to publish"
  type        = list(string)
  default     = []
}

variable "notification_emails" {
  description = "List of emails"
  type        = list(string)
  default     = []
}
