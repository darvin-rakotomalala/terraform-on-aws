# module for vpc
module "vpc" {
  source = "./vpc"
}

# module for auto-scaling group
module "auto-scaling" {
  source               = "./auto-scaling"
  vpc_id               = module.vpc.vpc_id
  priv_subnets         = module.vpc.private_subnet_ids
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
}

# module for bastion host
module "bastion_host" {
  source               = "./bastion_host"
  vpc_id               = module.vpc.vpc_id
  priv_subnets         = module.vpc.private_subnet_ids
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
}

# module for load balancer
module "load_balancer" {
  source         = "./load_balancer"
  vpc_id         = module.vpc.vpc_id
  private_asg_id = module.auto-scaling.private_asg_id
  #  priv_subnets = module.vpc.private_subnet_ids
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
}
