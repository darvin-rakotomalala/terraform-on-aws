## Creating VPC Flow logs to publish to Amazon CloudWatch Logs using Terraform

This guide explores how to create VPC Flow logs to publish to Amazon CloudWatch Logs using Terraform.

**VPC Flow Logs** is a feature in Amazon Web Services (AWS) that enables capturing information about IP traffic going to
and from network interfaces in the Virtual Private Cloud (VPC). These logs provide detailed visibility into network
traffic, helping to monitor, troubleshoot, and analyze traffic patterns, security issues, and performance within the
VPC.

Enabling flow logs for an Amazon VPC involves four steps:

1. Create an IAM role to publish flow logs to CloudWatch Logs
2. Create a KMS Key to encrypt the CloudWatch Log Group
3. Create an Amazon CloudWatch Logs group
4. Attach the CloudWatch Logs group to the VPC to capture flow logs

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file="failover_terraform.tfvars")** – Preview the changes Terraform will make to match
  your configuration.
- **Apply (terraform apply -var-file="failover_terraform.tfvars" -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -var-file="failover_terraform.tfvars")** – Removes resources when no longer needed.
