## Creating Scalable AWS Infrastructure with Auto Scaling group & ALB using Terraform

In this project, we will write an IaC for creating the following resources:

- NAT gateways for both private subnets
- A bastion host in the public subnet of AZ1
- An Auto Scaling Group (ASG) of instances in the private subnets
- Application Load Balancer
- Security Groups for EC2 instances and Load Balancer
- Key pair for SSH

### KEY COMPONENTS

- NAT Gateway:

  - Allows instances in private subnets to access the Internet
  - Has an Elastic IP to provide a stable external IP
  - Instances route Internet-bound traffic to the NAT Gateway
  - The instance itself remains hidden from the Internet

- Bastion Host:

  - An EC2 instance placed in a public subnet
  - Used as a "jump box" to access instances in private subnets
  - Has a public IP to allow SSH access from the Internet
  - You SSH to the bastion host, then to the private instances

- Auto Scaling Group:

  - Manages a group of EC2 instances and scales them automatically
  - Has a minimum and maximum number of instances
  - Can scale based on metrics, schedules or CloudWatch alarms
  - Launches new instances using a Launch Configuration

- Application Load Balancer:
  - Distributes traffic to multiple EC2 instances
  - Handles traffic at the application layer (Layer 7)
  - Uses health checks to route traffic only to healthy instances
  - Supports HTTP/HTTPS and some TCP protocols
  - Can be internal or internet-facing

### ARCHITECTURE DIAGRAM

Here is the main architecture diagram of our project. The following are the things we are going to need for our project:

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
