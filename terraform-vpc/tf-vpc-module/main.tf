# main.tf
module "vpc" {
  source       = "./vpc"
  vpc_cidr     = "18.0.0.0/16"
  subnet_cidrs = ["18.0.1.0/24", "18.0.2.0/24"]
}
