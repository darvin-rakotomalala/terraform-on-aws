## Setting up AWS WAF v2 with Terraform

In this repository, I’ll show a basic example of how to build a WAF with AWS Managed Rules via Terraform.

### Steps

- **Create a Web ACL**
  Web ACL is a central resource. That provides the following features and so on.

  - Dashboard
  - Which rule sets to apply
  - Which AWS resources to configure
  - Log and Metrics settings

- Create RuleSets: "AWS Managed Rules" and "my own rules"
- Attach to CloudFront and ALB & Setting monitoring option

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
