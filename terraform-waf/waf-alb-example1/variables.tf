#Define AWS Region
variable "region" {
  description = "Infrastructure region"
  type        = string
  default     = "us-east-1"
}

#Define IAM User Access Key
variable "access_key" {
  description = "The access_key that belongs to the IAM user"
  type        = string
  sensitive   = true
  default     = ""
}

#Define IAM User Secret Key
variable "secret_key" {
  description = "The secret_key that belongs to the IAM user"
  type        = string
  sensitive   = true
  default     = ""
}

variable "name" {
  description = "The name of the application."
  type        = string
  default     = "app-1"
}

variable "ami_name" {
  description = "The ami name of the image from where the instances will be created"
  default     = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  type        = string
}

variable "instance_type" {
  description = "The instance type of the instance from where the instances will be created"
  default     = "t2.micro"
  type        = string
}

variable "vpc_cidr" {
  description = "the vpc cidr"
  default     = "18.20.20.0/26"
}

variable "subnet_cidr_public" {
  description = "cidr blocks for the public subnets"
  default     = ["18.20.20.0/28", "18.20.20.16/28", "18.20.20.32/28"]
  type        = list(any)
}
