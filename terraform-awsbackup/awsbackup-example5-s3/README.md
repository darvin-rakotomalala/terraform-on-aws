## Centralized S3 backup with AWS Backup in terraform

This guide shows how to centralize S3 backup with AWS Backup in terraform.

**What is AWS Backup?**
AWS Backup makes it easy to centrally configure backup policies and monitor backup activity for AWS resources, such as
Amazon Elastic Compute Cloud (EC2) instances, Amazon Elastic Block Store (EBS) volumes, Amazon Relational Database
Service (RDS) databases, Amazon DynamoDB tables, Amazon Elastic File System (EFS) file systems, Amazon FSx file systems,
and AWS Storage Gateway volumes.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
