## Creating CloudWatch Log Groups with Terraform

This guide shows a basic example how to create CloudWatch Log Groups using Terraform.

**CloudWatch** is a powerful monitoring tool provided by Amazon Web Services (AWS) that enables you to collect and track
data from various sources, including resources and applications running on AWS.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
