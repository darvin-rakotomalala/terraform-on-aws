## Create AWS Aurora MySQL using Terraform

In this repository, I’ll show a basic example of how to define an Aurora MySQL cluster with Terraform.

### STEPS

- 1. Provider Configuration
- 2. VPC and Networking (If not already existing)
- 3. DB Subnet Group
- 4. Security Group
- 5. Aurora DB Cluster
- 6. Aurora DB Instances
- 7. Output the cluster endpoint

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
