## Setting Up WAF on CloudFront using Terraform

In this repository, I’ll show a basic example of how to set up WAF on CloudFront using Terraform.

Setting up a Web Application Firewall (WAF) on Amazon CloudFront using Terraform is a powerful way to protect your web applications from common web exploits and vulnerabilities. AWS WAF helps you monitor HTTP and HTTPS requests, control access based on conditions, and filter out malicious traffic.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
