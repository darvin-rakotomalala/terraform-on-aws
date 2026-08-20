####################################################
# Create two VPC and components
####################################################

module "vpc_a" {
  source                = "./modules/vpc"
  name                  = "VPC-A"
  aws_region            = var.aws_region
  vpc_cidr_block        = var.vpc_cidr_block_a #"18.1.0.0/16"
  public_subnets_cidrs  = [cidrsubnet(var.vpc_cidr_block_a, 8, 1)]
  private_subnets_cidrs = [cidrsubnet(var.vpc_cidr_block_a, 8, 2)]
  enable_dns_hostnames  = var.enable_dns_hostnames
  aws_azs               = var.aws_azs
  common_tags           = local.common_tags
  naming_prefix         = local.naming_prefix
}

####################################################
# Create IAM Roles, Policy and Attachment
####################################################

module "iam_ec2_s3" {
  source        = "./modules/iam"
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix
}

####################################################
# Create EC2 Server Instances
####################################################

module "vpc_a_bastion_host" {
  source           = "./modules/web"
  instance_type    = var.instance_type
  instance_key     = var.instance_key
  subnet_id        = module.vpc_a.public_subnets[0]
  vpc_id           = module.vpc_a.vpc_id
  ec2_name         = "Bastion Host A"
  sg_ingress_ports = var.sg_ingress_public
  common_tags      = local.common_tags
  naming_prefix    = local.naming_prefix
  ##instance_profile = module.iam_ec2_s3.instance_profile_name
}

module "vpc_a_private_host" {
  source           = "./modules/web"
  instance_type    = var.instance_type
  instance_key     = var.instance_key
  subnet_id        = module.vpc_a.private_subnets[0]
  vpc_id           = module.vpc_a.vpc_id
  ec2_name         = "Private Host A"
  sg_ingress_ports = var.sg_ingress_private
  common_tags      = local.common_tags
  naming_prefix    = local.naming_prefix
  instance_profile = module.iam_ec2_s3.instance_profile_name
}

####################################################
# Amend Private Host SG to allow traffic from Bastion Host SG
####################################################
resource "aws_security_group_rule" "public_in_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.vpc_a_private_host.security_group_id
  source_security_group_id = module.vpc_a_bastion_host.security_group_id
}

####################################################
# Create an S3 Bucket
####################################################
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-test-bucket-ct-69127"

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-bucket"
  })
}

####################################################
# Create Security Group and Gateway Endpoint
####################################################
resource "aws_vpc_endpoint" "s3_vpc_ep_gateway" {
  vpc_id            = module.vpc_a.vpc_id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids   = [module.vpc_a.private_route_table_id]

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-gateway-endpoint"
  })
}
