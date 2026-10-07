## Creating an AWS Lambda, S3 Event Notifications and DynamoDB with Terraform

In this repository, I’ll create a basic example of how to create an AWS Lambda and S3 Event Notifications to trigger a Lambda function to store data in DynamoDB with Terraform.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
