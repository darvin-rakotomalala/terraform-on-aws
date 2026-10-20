## Setting up Application Load Balancer (ALB) Across Multiple AZs using Terraform

In this repository, I will guide you through the process of setting up an Application Load Balancer (ALB) in front of a website distributed across multiple Availability Zones (AZs) using Terraform.

Application Load Balancer operates at the application layer (Layer 7) of the OSI model. It is best suited for routing HTTP/HTTPS traffic. It supports content-based routing and host-based routing and allows for routing decisions based on content and application behavior.

### Modules

- **vpc module** - to create vpc, public subnets, internet gateway, security groups and route tables
- **web module** - to create Linux Web EC2 instances with userdata script to display instance metadata using latest Amazon Linux ami in multiple subnets created in vpc module
- **alb module** - to create an application load balancer with target group containing ec2 instances from web module
- **main module** - Above modules get called in main config.

### Steps

- Creating the VPC and Network Components
- Creating Ubuntu EC2 Web Server Instances in Separate AZs
- Creating an Application Load Balancer
- Steps to run Terraform
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
