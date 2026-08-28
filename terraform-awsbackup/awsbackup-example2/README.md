## Back Up EC2 Instances with AWS Backup using Terraform

This guide shows how to back up EC2 Instances with AWS Backup using Terraform.

**AWS Backup** is a centralized service that automates backup scheduling, retention, and lifecycle management for EC2
instances (and many other AWS resources). It's far more reliable than homegrown cron scripts creating snapshots.

**Why AWS Backup Over Manual Snapshots**

- **Centralized management** - one dashboard for all your backups across services
- **Compliance reporting** - prove that backups are happening as required
- **Cross-region and cross-account copies** - built-in disaster recovery
- **Lifecycle policies** - automatically transition old backups to cold storage
- **Tag-based resource selection** - no need to maintain lists of instance IDs
- **Integration with AWS Organizations** - enforce backup policies across accounts

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
