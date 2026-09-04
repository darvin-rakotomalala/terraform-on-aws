## AWS API Gateway and AWS Route 53 using Terraform

This guide provides insights into how to connect Route 53 to API Gateway using Terraform. We must
create a custom domain name in API Gateway, manage an SSL certificate via AWS Certificate Manager (ACM), and then create
a Route 53 alias record pointing to the custom domain's generated hostname.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
