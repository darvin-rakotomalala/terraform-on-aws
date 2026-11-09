## Create AWS VPC Using Terraform

In this repository, I’ll show an example how to create a basic AWS VPC using Terraform.

### STEPS

- Step 1: Create **provider.tf**, **create_vpc.tf**, **subnet.tf**, **internet_gateway.tf**, **route_table.tf**, **route_table_association.tf**.
- Step 2: Run the below command

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.

### Best Practices of using Terraform for AWS VPC

The following are the best practices of using Terraform:

- **Modularize Your Code**: It helps in breaking your Terraform configuration into reusable modules for improving readability, manageability, and reusability of your infrastructure code.
- **Use Version Control**: To keep your Terraform code in a version control system like Git for tracking changes and collaborations with others, and rollback if necessary.
- **State Management**: It helps in using the remote state backends, such as S3 with DynamoDB for state locking, to manage and secure your Terraform state files effectively.
- **Environment Segregation**: It helps in creating a separate workspaces or use different state files for different environments (development, staging, production) to avoid conflicts and manage infrastructure lifecycle better.
