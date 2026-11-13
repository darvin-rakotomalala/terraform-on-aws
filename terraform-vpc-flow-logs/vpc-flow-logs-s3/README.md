## Create VPC Flow Logs to S3 with Terraform

This guide explores how to create VPC Flow Logs that stream to S3 using Terraform for cost-effective long-term
storage, compliance, and batch analysis of network traffic.

**VPC Flow Logs** capture detailed information about network traffic in your VPC. While streaming to CloudWatch is great
for real-time monitoring, sending flow logs to S3 is the preferred choice for long-term storage, compliance
requirements, and batch analytics. S3 is significantly cheaper for storing large volumes of log data, supports lifecycle
policies for automatic archival, and integrates with analytics tools like Athena for SQL-based querying.

### Best Practices

- Use Parquet format for better compression and query performance.
- Enable Hive-compatible partitions for efficient Athena queries.
- Use per-hour partitioning for granular data access.
- Set up lifecycle policies to reduce storage costs over time.
- Enable bucket versioning and encryption for security and compliance.
- Use Athena partition projection to avoid manual partition management.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file="failover_terraform.tfvars")** – Preview the changes Terraform will make to match
  your configuration.
- **Apply (terraform apply -var-file="failover_terraform.tfvars" -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -var-file="failover_terraform.tfvars")** – Removes resources when no longer needed.
