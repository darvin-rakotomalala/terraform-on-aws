## Creating a Multiple AWS KMS keys and secrets with Terraform

In this repository, I’ll show a basic example of how to create multiple CMKs (Customer Managed Keys) in AWS KMS (Key Management Service) with Terraform with unique aliases from a list of variables with Terraform.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan --var-file=us-east-1.tfvars)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply --var-file=us-east-1.tfvars -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy --var-file=us-east-1.tfvars -auto-approve)** – Removes resources when no longer needed.
