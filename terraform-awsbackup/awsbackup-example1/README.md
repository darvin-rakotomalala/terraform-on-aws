## Backing Up an EC2 Instance with AWS Backup using Terraform

This guide shows how to back up an EC2 Instance with AWS Backup using Terraform.

**AWS Backup** is a fully managed backup service that simplifies the centralization and automation of data backup across
AWS services. AWS Backup automates backup tasks such as scheduling, retention, and life cycle management. This
eliminates the need to develop custom scripts or manual processes.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
