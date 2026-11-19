## Integrate AWS WAF with AWS ALB using Terraform

In this repository, I’ll show a basic example of how to integrate AWS WAF with AWS ALB using Terraform.

**What is AWS WAF?**
AWS WAF is a web application firewall that lets you monitor the HTTP(S) requests that are forwarded to your protected web application resources. You can protect the following resource types:

- Amazon CloudFront distribution
- Amazon API Gateway REST API
- Application Load Balancer
- AWS AppSync GraphQL API
- Amazon Cognito user pool
- AWS App Runner service
- AWS Verified Access instance

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
