## Create a AWS VPC using Terraform

In this repository, I’ll show an example how to creat a Secure and Scalable AWS VPC with Terraform. This setup includes creating public and private subnets, routing tables, a NAT gateway, and security groups to ensure a secure and scalable network environment.

### Terraform Configuration Breakdown

We’ll be creating the following AWS resources:

- **VPC**: The virtual network where our resources will reside.
- **Subnets**: Public and private subnets to separate different types of resources.
- **Internet Gateway (IGW)**: Allows instances in the public subnet to access the internet.
- **NAT Gateway**: Provides internet access to instances in the private subnet.
- **Route Tables**: Direct traffic between subnets and the internet.
- **Security Groups**: Define inbound and outbound rules for instances.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
