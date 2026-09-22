####################################################
# Create VPC and components
####################################################

module "vpc" {
  source               = "./modules/vpc"
  name                 = "VPC-ECS"
  aws_region           = var.aws_region
  vpc_cidr_block       = var.vpc_cidr_block #"18.0.0.0/16"
  enable_dns_hostnames = var.enable_dns_hostnames
  aws_azs              = var.aws_azs
  common_tags          = local.common_tags
  naming_prefix        = local.naming_prefix
}

####################################################
# Create network components
####################################################

module "network" {
  source                 = "./modules/network"
  aws_region             = var.aws_region
  instance_type          = var.instance_type
  instance_key           = var.instance_key
  vpc_id                 = module.vpc.vpc_id
  alb_security_group_id  = module.alb.alb_security_group_id
  private_route_table_id = module.vpc.private_route_table_id
  private_subnets        = module.vpc.private_subnets
  common_tags            = local.common_tags
  naming_prefix          = local.naming_prefix
}

####################################################
# Create ECS Cluster
####################################################

module "ecs" {
  source               = "./modules/ecs"
  aws_region           = var.aws_region
  ecs_cluster_name     = var.ecs_cluster_name
  alb_target_group_arn = module.alb.alb_target_group_arn
  security_group_ecs   = module.network.security_group_ecs
  private_subnets      = module.vpc.private_subnets
  common_tags          = local.common_tags
  naming_prefix        = local.naming_prefix
}

####################################################
# Create load balancer with target group
####################################################

module "alb" {
  source         = "./modules/alb"
  aws_region     = var.aws_region
  aws_azs        = var.aws_azs
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  common_tags    = local.common_tags
  naming_prefix  = local.naming_prefix
}
