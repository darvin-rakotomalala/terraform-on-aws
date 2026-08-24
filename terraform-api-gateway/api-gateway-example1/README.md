## Create API Gateway & AWS Lambda using Terraform

In this repository, I’ll show a basic example of how to Create API Gateway Using Terraform & AWS Lambda.

### Steps

- Create API Gateway
- Create Lambda application code using NodeJS
- Create an AWS Lambda function
- Integrate Lambda function with API Gateway
- Provision appropriate access for the Lambda function
- Enable the CORS
- Test the deployment using Postman

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
