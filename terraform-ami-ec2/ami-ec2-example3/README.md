## Launch EC2 Instance from Custom AMI Using Terraform

This guide shows how to launch EC2 Instance from Custom AMI Using Terraform.

An **AWS AMI (Amazon Machine Image)** is a pre-configured template used to create virtual machines (or **instances**) in
Amazon Web Services (AWS). It contains the **operating system, software**, and **configuration settings** required to
launch and run a specific environment on AWS.

**Simple Step-by-Step Explanation (Why & What Happens)**

**What is an AMI (simple words)?**
Think of an AMI as:

- A snapshot + blueprint of an EC2
- It contains:
- OS
- Installed software
- Configuration
- Disk data

**Why create an AMI?**

- Backup an EC2
- Create identical servers
- Scale quickly
- Disaster recovery

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
