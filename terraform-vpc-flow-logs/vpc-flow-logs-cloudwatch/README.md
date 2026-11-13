## Create VPC Flow Logs to CloudWatch with Terraform

This guide explores how to create VPC Flow Logs that stream to CloudWatch Logs using Terraform for real-time network
traffic monitoring and analysis.

**VPC Flow Logs** capture information about the IP traffic going to and from network interfaces in your VPC. When
streamed to CloudWatch Logs, you can create metric filters, alarms, and dashboards for real-time network monitoring.
This is essential for security auditing, troubleshooting connectivity issues, and understanding traffic patterns.

### Best Practices

- Set appropriate log retention periods to control costs.
- Use the 1-minute aggregation interval for near-real-time monitoring.
- Create metric filters for the most critical traffic patterns. Use REJECT-only flow logs on sensitive ENIs to reduce
  log volume.
- Consider using the custom log format to include additional useful fields like AZ and flow direction.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file="failover_terraform.tfvars")** – Preview the changes Terraform will make to match
  your configuration.
- **Apply (terraform apply -var-file="failover_terraform.tfvars" -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -var-file="failover_terraform.tfvars")** – Removes resources when no longer needed.
