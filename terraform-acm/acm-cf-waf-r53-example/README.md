## Deploying a Secure, Low-Latency Website with CloudFront, WAF, Route 53, ACM, and Terraform

In this repository, I’ll show an example of how to to setup a low latency website using CloudFront with S3 as a origin, WAF and ACM to add security using Terraform.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
