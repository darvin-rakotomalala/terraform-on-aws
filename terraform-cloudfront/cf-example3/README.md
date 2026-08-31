## Create CloudFront distribution from an S3 bucket using Terraform

In this repository, I’ll show an example how to create a basic example of CloudFront distribution from an S3 bucket with Origin Access Control (OAC) using Terraform.

This project creates:

- **S3 Bucket**: Secure storage for static website files
- **CloudFront Distribution**: Global CDN with HTTPS redirect
- **Origin Access Control (OAC)**: Secure access from CloudFront to S3
- **IAM Policies**: Proper permissions for CloudFront to access S3

Security Features:

- **Private S3 Bucket**: All public access is blocked
- **Origin Access Control (OAC)**: Modern replacement for Origin Access Identity
- **HTTPS Enforcement**: CloudFront redirects HTTP to HTTPS
- **Proper IAM Policies**: Least privilege access for CloudFront

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
