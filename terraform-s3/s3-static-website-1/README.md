## Hosting a Static Website on AWS S3 using Terraform

In this project, we’ll explore deploying static websites efficiently on AWS using Terraform..

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file terraform-dev.tfvars)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve -var-file terraform-dev.tfvars)** – Make the planned changes.
- **Destroy (terraform destroy -var-file terraform-dev.tfvars)** – Removes resources when no longer needed.
