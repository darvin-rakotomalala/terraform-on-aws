## Associate an Elastic IP to an EC2 Instance using Terraform

In this repository I’ll show how to associate an Elastic IP to an EC2 Instance in your default aws vpc with terraform.

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
