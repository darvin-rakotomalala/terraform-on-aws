## Creating Autoscaling And Autoscaling Group Using Terraform

In this repository, I’ll show an example how to configure an AWS Autoscaling And Autoscaling Group Using Terraform.

### Steps

- Define launch template
- Creating VPC and Subnets
- Define Autoscaling Group
- Define Scaling Policies

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
