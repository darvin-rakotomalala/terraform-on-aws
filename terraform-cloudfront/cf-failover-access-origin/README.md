## Deploying a CloudFront with Primary and Failover Access Origin using Terraform

In this repository, I’ll show an example how to deploy a CloudFront with Primary and Failover Access Origin using Terraform.

### Steps

- Creating Primary and Failover S3 Buckets
- Configuring CloudFront Distribution
- Updating S3 Bucket Policies
- Run Terraform
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
