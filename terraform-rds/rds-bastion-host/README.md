## Create AWS RDS with Bastion Host Using Terraform

In this repository, I’ll show an example how to automate secure AWS infrastructure using Terraform — including VPC, public/private subnets, a MySQL RDS database, and a Bastion host for secure access. Rather than exposing the database to the public internet, I implemented best practices by placing the RDS instance in **private subnets**, accessible only via a **bastion host** in a public subnet.

### Infrastructure Overview

This project provisions a complete, production-style AWS environment using Terraform. The following resources will be created:

- **Networking**
  - A **custom VPC** with a CIDR block (`18.0.0.0/16`)
  - **Two private subnets** in different Availability Zones (for the RDS instance)
  - **One public subnet** (for the bastion host)
  - **Internet Gateway** and **Route Tables** for public subnet routing
  - A **DB Subnet Group** for multi-AZ RDS deployment
- **Compute**
  - A **bastion EC2 instance** in the public subnet
  - Used to SSH into the private subnets and access the database securely
  - Provisioned with a custom security group allowing only port 22 (SSH) access
- **Database**
  - A **MySQL RDS instance**
  - Deployed in private subnets (not accessible from the public internet)
  - Configured with a dedicated security group that allows access only from the bastion host
- **Security**
  - Security groups:
  - Bastion SG: allows inbound SSH (port 22) from your IP
  - RDS SG: allows inbound MySQL (port 3306) from the bastion’s SG

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file=terraform-dev.tfvars)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve -var-file=terraform-dev.tfvars)** – Make the planned changes.
- **Destroy (terraform destroy -var-file=terraform-dev.tfvars)** – Removes resources when no longer needed.
