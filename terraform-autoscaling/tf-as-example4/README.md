## Using Terraform to Launch an Auto Scaling Group, a Security Group, an Apache Web Server

In this repository, using Terraform I launched an Auto Scaling Group to span 2 of my default VPC’s subnets. Additionally, I created a Security Group that enabled traffic from the Internet, attaching it to my Auto Scaling Group instances. I then built a Bash script to launch an Apache web server, deploying a minimum of 2 and maximum of 5 EC2 instances.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
