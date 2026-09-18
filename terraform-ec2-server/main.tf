
module "vpc" {
  source                        = "./modules/vpc"
  aws_region                    = var.aws_region
  vpc_cidr_block                = var.vpc_cidr_block
  enable_dns_hostnames          = var.enable_dns_hostnames
  vpc_public_subnets_cidr_block = var.vpc_public_subnets_cidr_block
  aws_azs                       = var.aws_azs
  common_tags                   = local.common_tags
  naming_prefix                 = local.naming_prefix
}


module "web" {
  source        = "./modules/web"
  instance_type = var.instance_type
  instance_key  = var.instance_key
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix

  subnet_id       = module.vpc.subnet_id
  security_groups = module.vpc.security_group
}
