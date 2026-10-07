## Setting Up VPC and Lambda Function with Terraform

In this repository, I’ll create a basic example of how to set up VPC and Lambda Function with Terraform. By following these steps and utilizing the Terraform code provided, you can set up a secure and efficient environment for your application on AWS. This setup involves creating and configuring a VPC, subnets, route tables, internet gateway, NAT gateway, VPC endpoints, and associating them appropriately.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
