output "vpc_a_bastion_host_IP" {
  value = module.vpc_a_bastion_host.public_ip
}

/*
output "vpc_a_private_host_IP" {
  value = module.vpc_a_private_host.private_ip
}
*/
