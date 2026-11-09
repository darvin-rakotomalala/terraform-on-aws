## Create Custom EC2, Security Group, and VPC Modules in Terraform

In this repository, I’ll show an example how to create custom EC2, Security Group, and VPC Modules in Terraform.

### Why do we use Terraform Modules?

- Reusability
- Consistency
- Scalability
- Maintainability
- Collaboration

### Steps Guide:

- Create a custom EC2 module that can be used as repeatable infrastructure.
- Create a Security Group module that allows for HTTP web access.
- Create a VPC module.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
