## Create EFS File Systems with Terraform

This guide shows how to create EFS File Systems with Terraform. Complete guide to provisioning AWS Elastic File System (
EFS) with Terraform, covering mount targets, access points, security groups, and lifecycle policies.

Amazon Elastic File System gives you a shared file system that multiple EC2 instances, ECS containers, or Lambda
functions can mount simultaneously. It's the go-to choice when your workloads need shared persistent storage that scales
automatically.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
