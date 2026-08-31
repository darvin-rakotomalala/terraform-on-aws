## Hosting a Static Website on S3 Bucket with CloudFront and a Custom Domain using Terraform

In this repository, I’ll show an example how to how to host a static website on an S3 Bucket with CloudFront and a custom domain using Terraform.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file="custom.tfvars")** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -var-file="custom.tfvars" -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -var-file="custom.tfvars")** – Removes resources when no longer needed.
