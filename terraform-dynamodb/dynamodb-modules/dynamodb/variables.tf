### dynamodb/variables.tf

variable "aws_region" {
  description = "The region where the instance will be deployed to"
  type        = string
  default     = "us-east-1"
}

variable "table_name" {
  description = "Dynamodb table name"
  type        = string
  default     = "sneakers_table"
}

variable "environment_name" {
  description = "Name of environment"
  default     = "Sneaker_test"
}

variable "environment_type" {
  description = "Type of environment"
  default     = "Training"
}
