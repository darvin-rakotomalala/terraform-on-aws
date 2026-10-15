## Create AWS load balancer using terraform

In this repository, we will see how to create AWS load balancer using terraform.

### STEPS

- Creation of VPC
- Creation of Subnet
- Internet Gateway Creation
- Creation of Rout Table
- Creation of EC2 instance + User data
- Creation of Security Group
- Creation of load balancer

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
