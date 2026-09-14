## Configure EC2 storage using Terraform

Configuring **EC2 storage** using Terraform primarily involves managing Elastic Block Store (EBS) volumes, which provide persistent block-level storage for EC2 instances.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed

### STEPS

- Step 1: Create **provider.tf**, **ec2.tf**, and **sg.tf**.
- Step 2: Defining EBS Volumes
- Step 3: Attaching EBS Volumes to EC2 Instances
- Step 4: Run the above commands
