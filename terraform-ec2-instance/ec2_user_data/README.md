## Creating an EC2 instance with user_data

Setting up **user data** on an EC2 instance involves providing a script or configuration that the instance will execute during its initial launch. This allows for automated setup and configuration, such as installing software, configuring services, or creating files.

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
