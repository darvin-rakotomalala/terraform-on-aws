## Designing a Scalable VPC Architecture on AWS using Terraform

In this repository, I’ll walk you through how I set up a robust and scalable VPC on AWS using Terraform. The architecture I used isn’t just functional, it’s secure, scalable and production ready. It follows best practices like:

- Separation of environments using different private subnets for dev and prod.
- High availability with subnets spread across three Availability Zones.
- Secure internet access using a NAT Gateway for private resources.
- Public access where needed, thanks to an Internet Gateway.
- Clear routing logic with dedicated route tables for each subnet group.

### Steps

- VPC Creation
- Internet Gateway
- Public Subnets
- NAT Gateway and Elastic IP
- Private Subnets
  - Dev Private Subnets — used for development and staging environments
  - Prod Private Subnets — used for production workloads
- Route Tables and Subnet Associations
- VPC Gateway Endpoints

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
