## Creating an ECS Cluster Using Fargate with Terraform

In this repository, I’ll show a basic example of how to create an ECS Cluster Using Fargate with Terraform. We will then build out a Fargate cluster using Terraform. This will include an autoscaling group, load balancer, IAM Roles, security group, and the creation of a new VPC.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
