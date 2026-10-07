## Configuring an AWS Lambda Function with Lambda Layers using Terraform

In this repository, I’ll create a basic example of configuring an AWS Lambda Function with Lambda Layers with Terraform.

**Why Does AWS Lambda Require Layers?**

AWS Lambda has a constrained execution environment with a pre-configured set of runtime libraries. If your function requires additional dependencies (e.g., requests for making HTTP calls), you must either:

- Bundle dependencies within your deployment package, or
- Use Lambda Layers, which provide a modular approach for managing dependencies across multiple Lambda functions.

Using layers helps:

- Reduce deployment package size.
- Promote reusability across multiple Lambda functions.
- Improve maintainability by keeping dependencies separate from function code.

**What Are Lambda Function URLs?**

Lambda Function URLs allow users to invoke Lambda functions directly via an HTTP(S) endpoint without needing an API Gateway. This feature simplifies web service development, reducing complexity and cost. Function URLs are useful for creating lightweight APIs, webhooks, and integrations where API Gateway might be unnecessary.

### Steps

- Define IAM Role and Policy
- Create a Lambda Layer for `requests` Library
- Define Lambda Function Code
- Define the Lambda Function
- Create a Lambda Function URL
- Steps to Run Terraform
- Testing
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
