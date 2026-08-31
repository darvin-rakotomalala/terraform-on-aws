## Hosting static website with Amazon CloudFront and S3 using Terraform

In this repository, I’ll show an example how to create a basic example of hosting static website with Amazon CloudFront and S3 using Terraform.

### Steps

- 1. Creating an S3 Bucket with Blocked Public Access
- 2. Creating a CloudFront Distribution with an S3 Origin
- 3. Adding an Origin Access Control (OAC) to the CloudFront Distribution
- 4. Updating the S3 Bucket Policy to Allow CloudFront Access

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
