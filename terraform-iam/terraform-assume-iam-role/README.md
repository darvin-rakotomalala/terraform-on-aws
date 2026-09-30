## Setting up cross-account AWS IAM roles with Terraform

In this repository I’ll show an example how to create a cross-account AWS IAM roles with Terraform.

### STEPS

- Step 1: Create **provider.tf** and **assume-role.tf**.
- Step 2: Run the below command

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
