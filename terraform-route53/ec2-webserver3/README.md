## Deploying EC2 Webserver Instances in a Private Subnet

In this repository, I’ll show a basic example of how to deploy EC2 Webserver Instances in a Private Subnet with Internet Access via NAT Gateway using Terraform.

A NAT (Network Address Translation) gateway plays a crucial role in scenarios where instances in private subnets need access to the internet for updates, patches, or communication with external services, but you want to keep these instances secure from inbound internet traffic. The NAT gateway allows outbound connections to the internet while ensuring that inbound connections initiated from the internet are blocked.

### Steps

- Creating the VPC and Network Components
- Creating 2 Ubuntu EC2 Web Server Instances in Separate AZs
- Creating an Application Load Balancer with HTTP Listener
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
