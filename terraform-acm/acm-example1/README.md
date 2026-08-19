## Creating SSL Certificates using ACM with Terraform

In this repository, I’ll show a basic example of how to leverage Terraform to automate the creation of an SSL/TLS certificate with ACM and implement DNS validation for secure and streamlined certificate management.

### Steps

- Request an ACM Certificate
- Create Route 53 DNS Record for Validation
- Handle Certificate Validation
- Run Terraform
- Testing
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
