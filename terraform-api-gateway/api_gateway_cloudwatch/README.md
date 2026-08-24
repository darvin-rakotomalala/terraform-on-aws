## CloudWatch logging for API Gateway using Terraform

To enable CloudWatch logging for an `aws_api_gateway_stage` in Terraform, the CloudWatch log role ARN must be configured at the API Gateway account level, and then logging can be enabled on the specific stage.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
