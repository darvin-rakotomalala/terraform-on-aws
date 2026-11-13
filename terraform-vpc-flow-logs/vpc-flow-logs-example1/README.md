## Creating VPC Flow Logs with Terraform

This guide explores the seamless integration of VPC Flow Logs into your AWS environment using Terraform, enabling you to
gain a deeper understanding of network activities within your VPC.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file="failover_terraform.tfvars")** – Preview the changes Terraform will make to match
  your configuration.
- **Apply (terraform apply -var-file="failover_terraform.tfvars" -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -var-file="failover_terraform.tfvars")** – Removes resources when no longer needed.
