## Securing EC2 Website with HTTPS using ACM Certs and Route 53 with Terraform

In this repository, I’ll show a basic example of how to secure EC2 Website with HTTPS using ACM Certs and Route 53 built with Terraform.

Securing a website with HTTPS not only improves security and AWS makes it relatively easy to set up SSL certificates and manage them through ACM. By following the steps below, you can secure your existing website hosted on EC2 instances behind an Application Load Balancer.

### Steps

- Creating the VPC and Network Components
- Creating Ubuntu EC2 Web Server Instances in Separate AZs
- Request an ACM Certificate
- Create Route 53 DNS Record for Validation
- Creating an Application Load Balancer with HTTPS Listener
- Run Terraform
- Testing
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
