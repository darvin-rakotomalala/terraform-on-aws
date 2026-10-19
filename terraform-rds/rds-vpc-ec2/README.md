## Build Scalable AWS Infrastructure Using Terraform Modules (VPC, EC2, RDS)

In this repository, I’ll show an example how to Build Scalable AWS Infrastructure using Terraform Modules (VPC, EC2, RDS).

**What We’ll Build**

Here’s a snapshot of the infrastructure we’ll be creating:

- A **Virtual Private Cloud (VPC)** with a custom CIDR block
- A **public subnet** hosting an EC2 instance for web access.
- A **private subnet** hosting an RDS MySQL database
- **Security groups** to control access between services
- **Modular, reusable Terraform code** structured for scale

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
