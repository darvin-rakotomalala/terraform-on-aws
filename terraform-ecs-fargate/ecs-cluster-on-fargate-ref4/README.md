## Creating an ECS Cluster Using Fargate with Terraform & AWS Community Modules

In this repository, I’ll show a basic example of how to use Terraform AWS Community Modules to provision the infrastructure and deploy a simple Node.js app hosted in a public Amazon ECR repository.

This setup ensures:

- Scalability with autoscaling policies
- Cost efficiency with Fargate Spot
- Security by running tasks in private subnets behind an ALB

### Steps

- Create VPC and ECS Cluster
- Create ECS Execution & Task Roles
- Create ALB with Target Group
- ECS Task Definition with Node.js Image
- ECS Service with Autoscaling

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
