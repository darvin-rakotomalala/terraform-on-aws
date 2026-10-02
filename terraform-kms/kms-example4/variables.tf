variable "aws_region" {
  type        = string
  description = "AWS provider to be used to create roles, policies, S3 objects, ..."
}

variable "clustername" {
  type = list(any)
}
