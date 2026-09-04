variable "aws_region" {
  type        = string
  description = "AWS region to use for resources."
  default     = "us-east-1"
}

variable "domain_name" {
  type    = string
  default = "cloudwithdarvin.com"
}

variable "authorization_scopes" {
  type        = string
  description = "Authorization Scope for API Gateway"
  default     = "myapi/all"
}
