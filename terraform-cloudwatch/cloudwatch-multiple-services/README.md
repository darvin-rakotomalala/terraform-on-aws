## configuring AWS CloudWatch monitoring using Terraform

This guide shows an example how to configure AWS CloudWatch monitoring for multiple services using Terraform.

Monitoring and observability are essential for maintaining the health and performance of cloud-based applications. AWS
CloudWatch provides powerful monitoring capabilities, allowing you to collect logs, track metrics, set up alarms, and
trigger notifications.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
