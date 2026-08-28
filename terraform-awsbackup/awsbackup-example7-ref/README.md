## AWS Backup using Terraform

This is an AWS Backup implementation using Terraform with security and operational best practices in mind.

The following services are supported:

- RDS
- EBS
- EFS
- DynamoDB

**Workflow**

- AWS Backup selects resources to backup using resource tags. The resource tags determine the backup plan to use.
- A lambda function identifies resources without the backup_policy tag, auto-tags those resources with the default
  backup plan and notifies the operations team.
- Backups are performed using the AWS Backup service. All backups are stored in a backup vault named backup_vault.

**Security**

This Terraform config adds extra security to the AWS backup vault setup by applying a resource policy that prevents any
user from:

- Removing the recovery points
- Removing the backup vault
- Changing or removing the resource policy which imposes the previous restrictions

This means that only the root account will ever be able to remove this backup vault! The backup vault will survive even
in a scenario where a privileged IAM principal with *:* permissions is compromised.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
