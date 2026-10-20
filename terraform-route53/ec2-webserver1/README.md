## Deploying a Linux Web Server on AWS EC2 Instance using Terraform

In this repository, I will guide you through the steps of launching a simple website on an EC2 Linux instance using Terraform. It will use single AZ, single EC2 server without auto-scaling.

### Steps

- Creating the VPC and Network Components
- Launching an EC2 Instance with Apache Web Service
- Run Terraform

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
