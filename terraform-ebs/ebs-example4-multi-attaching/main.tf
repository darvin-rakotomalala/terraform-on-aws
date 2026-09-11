####################################################
# Create VPC and components
####################################################

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

####################################################
# Create Web Server Instances
####################################################

module "web" {
  source             = "./modules/web"
  instance_type      = var.instance_type
  instance_key       = var.instance_key
  common_tags        = local.common_tags
  naming_prefix      = local.naming_prefix
  public_subnets     = module.vpc.public_subnets
  security_group_ec2 = module.vpc.security_group_ec2
}

####################################################
# Create EBS Multi attach Volume and attach to all EC2 instances
####################################################

resource "aws_ebs_volume" "volume" {
  availability_zone    = var.aws_azs
  size                 = 4
  type                 = "io2"
  iops                 = 200
  multi_attach_enabled = true

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-EBS"
  })
}

resource "aws_volume_attachment" "ebsAttach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volume.id
  count       = length(module.web.instance_ids)
  instance_id = element(module.web.instance_ids, count.index)
}
