## Create an Amazon Machine Image (AMI) from an EC2 Instance using Terraform

This guide shows how to create an Amazon Machine Image (AMI) from an EC2 Instance using Terraform.

An **AWS AMI (Amazon Machine Image)** is a pre-configured template used to create virtual machines (or **instances**) in
Amazon Web Services (AWS). It contains the **operating system, software**, and **configuration settings** required to launch
and run a specific environment on AWS.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
