## Create VPC Interface Endpoint using Terraform

In this repository, I’ll show a basic example of how to create VPC Interface Endpoint with Terraform.
Creating and linking an AWS Interface VPC Endpoint with Terraform involves several steps: defining the endpoint, creating a security group to control access, and enabling private DNS resolution to use the service's default public DNS names.

_Nb: Route Table Association (Not required for interface endpoints)_

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
