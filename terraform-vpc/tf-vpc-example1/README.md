## Building AWS VPC using Terraform

In this repository, I’ll show an example how to develop a basic AWS VPC using Terraform.

### Key components

- VPC in us-east-1 zone
- Internet Gateway
- Public Subnets, one in each AZ
- Private Subnets, one in each AZ
- Route Table configurations (main RT local target and 2nd RT IGW)

### STEPS

- Step 1: Create **provider.tf**, **variables.tf** and **main.tf**.
- Step 2: Run the below command

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
