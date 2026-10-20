## Create private Hosted zone Route 53 using Terraform

In this repository, I’ll show a basic example of how to create a private Hosted zone Route 53 using Terraform.

Private hosted zones within Route 53 are specifically designated for accessibility within an Amazon Virtual Private Cloud (VPC). These zones empower users to establish and oversee domain names within their VPC, enabling the efficient routing of traffic to Amazon EC2 instances and various other AWS resources.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
