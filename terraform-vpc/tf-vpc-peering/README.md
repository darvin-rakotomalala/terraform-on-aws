## Deploy AWS VPC Peering Using Terraform Using Terraform

In this project, I’ll show an example how to deploy AWS VPC Peering using Terraform.

**VPC peering** is a network connection between two VPCs that enables private communication between resource in the VPCs as if they were in the same network.

### Diagram architecture


### Tasks

We will create the following resources:

- 2 VPCs
- 2 Subnets
- 2 Internet Gateways
- 2 Route Tables
- 2 Security Groups
- 2 EC2 Instances
- 1 Peering Resource
- 1 AWS Key Pairs

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
