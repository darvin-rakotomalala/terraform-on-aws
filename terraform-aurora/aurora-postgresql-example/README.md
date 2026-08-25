## Create AWS Aurora PostgreSQL using Terraform

In this repository, I’ll show a basic example of how to define an Aurora PostgreSQL cluster with Terraform.

### STEPS

- 1. Define the AWS provider
- 2. Create a VPC for your Aurora cluster
- 3. Create subnets for your Aurora instances
- 4. Create a DB subnet group
- 5. Create a security group for the Aurora cluster
- 6. Create the Aurora PostgreSQL cluster
- 7. Create an Aurora PostgreSQL instance within the cluster
- 8. Output the cluster endpoint

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
