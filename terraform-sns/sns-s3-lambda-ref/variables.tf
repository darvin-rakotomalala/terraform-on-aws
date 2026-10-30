variable "region" {
  description = "Infrastructure region"
  type        = string
  default     = "us-east-1"
}

# application name
variable "name" {
  description = "The name of the application."
  type        = string
  default     = "app-69127"
}

variable "log_group_prefix" {
  description = "The name of the log group."
  type        = string
  default     = "/aws/lambda-69127/"
}

variable "log_retention_days" {
  description = "Number of days to retain Lambda logs"
  type        = number
  default     = 7
}
