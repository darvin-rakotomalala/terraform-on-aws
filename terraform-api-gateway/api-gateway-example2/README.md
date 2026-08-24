## Deploying Amazon API Gateway and Lambda with Terraform

In this repository, we'll be deploying an Amazon API Gateway with links to a Lambda Function using Terraform.

This Lambda will emulate typical CRUD operations (Create, Read, Update, and Delete) as if it was connected to a database, mapping the operations to HTTP requests for POST, GET, PUT and DELETE methods respectively.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
