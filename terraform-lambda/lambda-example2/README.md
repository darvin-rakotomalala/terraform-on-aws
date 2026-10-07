## Manage AWS Lambda Functions with Terraform

In this repository, I’ll create a basic example of how to create a Lambda Function using Terraform and then deploy a very simple Python app.

### Steps

- 1. Set up the IAM roles and policies
- 2. Write the Python application
- 3. Create a ZIP file of the Python application
- 4. Add the aws_lambda_function function
- 6. Verify the Lambda function from the AWS Console

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
