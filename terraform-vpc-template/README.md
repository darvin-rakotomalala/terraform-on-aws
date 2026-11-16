## Create an AWS VPC using Terraform

In this repository, I’ll show an example how to create a basic template of AWS VPC using Terraform.

This will include building:

- Custom VPC
- Subnets
- Route Tables
- Four instances, two public, and two private(containing RDS)
- A load balancer

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
