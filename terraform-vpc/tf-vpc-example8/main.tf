module "network-resources" {
  source = "./network-resources"
  vpc_id = module.network-resources.vpc_id
}

module "security-resources" {
  source = "./security-resources"
  vpc_id = module.network-resources.vpc_id
}

module "ec2-resources" {
  source = "./ec2-resources"

  vpc_id            = module.network-resources.vpc_id
  security_group_id = module.security-resources.security_group_id
  public_subnet_id  = module.network-resources.public_subnet_id
}

output "public_ip" {
  value = module.ec2-resources.public_ip
}

output "public_dns" {
  value = module.ec2-resources.public_dns
}
