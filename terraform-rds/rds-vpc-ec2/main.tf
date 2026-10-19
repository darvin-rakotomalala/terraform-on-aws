/*
  data "aws_ssm_parameter" "rds_password" {
  name = "/prod/rds/db_password"
  with_decryption = true
}
*/

# Call the VPC Module
module "vpc" {
  source          = "./modules/vpc"
  cidr_block      = "18.0.0.0/16"
  public_subnets  = ["18.0.1.0/24", "18.0.2.0/24"]
  private_subnets = ["18.0.3.0/24", "18.0.4.0/24"]
}

# Call the EC2 Instance Module
module "ec2" {
  source           = "./modules/ec2"
  ami_id           = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type    = "t2.micro"
  key_name         = "my-key-pair"
  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = "0.0.0.0/0"
  subnet_id        = module.vpc.public_subnet_ids[0] # Use the first public subnet
}

# Call the RDS Module
module "rds" {
  source   = "./modules/rds"
  db_name  = "my_rds_db"
  username = "root"
  # password               = data.aws_ssm_parameter.rds_password.value # ✅ Secure password
  password               = "root2025"
  subnet_ids             = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.vpc.rds_sg_id]
}
