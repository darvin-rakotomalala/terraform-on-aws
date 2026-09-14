## Creating an EC2 instance with Launch Template

Creating an EC2 instance using a launch template with Terraform involves two primary steps: defining the launch template and then referencing it when creating the EC2 instance.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed

### STEPS

- Step 1: Create **provider.tf**, **ec2.tf**, and **sg.tf**.
- Step 2: Defining the AWS Launch Template
- Step 3: Creating the EC2 Instance using the Launch Template
- Step 4: Run the above command.
