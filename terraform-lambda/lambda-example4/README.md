## Deploy Lambda function on AWS using Terraform

In this repository, I’ll create a basic example of how to deploy Lambda function on AWS using Terraform.

Quick TLDR: AWS Lambda is a service that handles serverless workloads, you write your business logic, deploy it and AWS handles the rest. You only pay when it runs.

### Steps

- Provide IAM Role
- Provide IAM Profile
- Attach IAM Policy to profile
- Create a ZIP file for upload
- Create the Lambda Function

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
