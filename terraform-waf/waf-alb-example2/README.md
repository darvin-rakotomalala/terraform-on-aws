## Setting Up WAF on ALB using Terraform

In this repository, I’ll show a basic example of how to configure WAF ACL and its association with an ALB using Terraform.

_Note: Please make sure your AWS LoadBalancer is available on the same AWS region you define above._

**What is Web ACL in WAF?**
A web access control list (web ACL) gives you fine-grained control over all of the HTTP(S) web requests that your protected resource responds to. You can protect Amazon CloudFront, Amazon API Gateway, Application Load Balancer, AWS AppSync, Amazon Cognito, and AWS App Runner resources.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
