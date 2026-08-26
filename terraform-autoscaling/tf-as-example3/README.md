## AutoScale EC2 Instances using Terraform

In this repository, I’ll show an example how to configure an AWS AutoScaling EC2 Instances using Terraform.

### Objectives:

- Launch an Auto Scaling group that spans 2 subnets in your new VPC
- Create a security group that allows traffic from the internet and associate it with the Auto Scaling group instances
- Include a script in your user data to launch an apache webserver. The Auto Scaling group should have a min of 2 and a max of 5
- To verify everything is working check the public IP addresses of the two instances. Manually terminate one of the instances to verify that another one spins up to meet the minimum requirement of 2 instances

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
