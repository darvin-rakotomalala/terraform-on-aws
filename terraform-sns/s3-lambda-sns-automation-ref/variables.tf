variable "region" {
  default = "us-east-1"
}

variable "email" {
  description = "Email to subscribe to SNS topic"
  type        = string
  default     = "darvintojo@gmail.com"
}
