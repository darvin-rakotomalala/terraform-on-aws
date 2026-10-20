## Build an AWS Route53 Failover routing policy with Terraform

In this repository, I’ll show a basic example of how to build AWS Route 53 Failover routing policy with Terraform where a primary record, the EC2 instance, will automatically switch over to a secondary backup record, an S3 bucket, after the primary indicated a failure on the AWS-Route53 health check.

Health checking is a great feature that AWS-Route53 uses to send automated requests over the internet to applications verifying that it is working, accessible and available.

Wou will focus on building and deploying the following AWS-services:
- Availability zone
- VPC
- Public subnet
- Internet gateway
- Route table
- EC2
- Security groups
- Elastic Ip
- Route 53
- S3 bucket

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
