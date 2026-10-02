variable "region" {
  default = "us-east-1"
}

variable "kms_alias" {
  default = "my_encryption_key"
}

variable "username" {
  default = "darvin-admin"
}

variable "key_spec" {
  default = "SYMMETRIC_DEFAULT"
}

variable "enabled" {
  default = true
}

variable "rotation_enabled" {
  default = true
}
