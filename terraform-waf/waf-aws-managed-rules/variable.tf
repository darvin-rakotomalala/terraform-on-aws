variable "prefix" {
  type    = string
  default = "demo"
}

variable "name" {
  type    = string
  default = "waf-cf"
}

variable "metric_name" {
  type    = string
  default = "waf-cf"
}

variable "bucket" {
  type    = string
  default = "aws-waf-logs-cf-69127"
}
