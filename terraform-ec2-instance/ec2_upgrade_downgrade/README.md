## Upgrading and Downgrading an EC2 Instance Type with Terraform

In this repository I’ll show an example how to upgrade and downgrade an EC2 Instance Type with terraform.
Example : Upgrading Instance type from **t2.micro** to **t2.medium**.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed

### STEPS

- Step 1: Create **provider.tf**, **ec2.tf**, and **sg.tf**.
- Step 2: Run the above command.
