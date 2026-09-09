## AWS Route 53 Failover Disaster Recovery Active/Active with Terraform

Multi-region disaster recovery setup with automatic failover using Route 53, ACM (HTTPS), and Application Load Balancers
using Terraform.

### 📦 Resources Created

**Per Region:**

- 1 VPC with 2 public subnets
- 1 Internet Gateway
- 1 Route Table
- 1 EC2 Instance (t2.micro)
- 1 Application Load Balancer
- 1 Target Group
- 1 ACM Certificate
- 2 Security Groups (ALB + EC2)

**Global (Route 53):**

- 1 Health Check
- 2 Failover Records (Primary + Secondary)

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file="failover_terraform.tfvars")** – Preview the changes Terraform will make to match
  your configuration.
- **Apply (terraform apply -var-file="failover_terraform.tfvars" -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -var-file="failover_terraform.tfvars")** – Removes resources when no longer needed.
