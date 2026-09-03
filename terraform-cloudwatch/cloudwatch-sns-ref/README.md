## Setting Up CloudWatch Alarms for CPU Utilization on AWS EC2 Instances with Terraform

This guide shows a basic example how to create AWS CloudWatch Alarms to monitor CPU utilization and set up email
notifications using Terraform.

### Steps

- Create VPC, Network Components, and EC2 Instances
- Set Up SNS Topic for Email Notifications
- Create CloudWatch Metric Alarms
- Testing CloudWatch Alarms with SNS topic

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
