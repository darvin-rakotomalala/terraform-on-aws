## Manage DynamoDB Tables With Terraform

In this repository, I’ll show a basic example of how to manage AWS DynamoDB Table Using Terraform.

Amazon describes DynamoDB as: Serverless, NoSQL, fully managed database with single-digit millisecond performance at any scale.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
