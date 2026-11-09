## Create a AWS VPC using Terraform

In this repository, I’ll show an example how to create a AWS VPC using Terraform.

For this VPC, 3 public and 3 private subnets will be created, along with an Internet Gateway, Route Table, and NAT Gateway.

The goal for this VPC setup is to allow our private resources access to the internet, and restrict access from the internet to our resources.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file=demovpc.tfvars)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve -var-file=demovpc.tfvars)** – Make the planned changes.
- **Destroy (terraform destroy -var-file=demovpc.tfvars)** – Removes resources when no longer needed.
