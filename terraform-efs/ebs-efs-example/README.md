## Setting up AWS EBS & EFS with Terraform

This guide shows how to use Terraform to automate EBS and EFS, and add EBS volumes or EFS file shares to your automated
deployments.

### Steps

- Attach an EBS Volume to an EC2 Instance Using Terraform
- Creating AWS Elastic Filesystems with Terraform

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
