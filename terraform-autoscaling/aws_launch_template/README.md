## Auto Scaling Group on AWS with Terraform

In this repository, we create an example AWS Auto Scaling Group on AWS with Terraform.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.

### Test

To test our Auto Scaling Group to see if it works as expected. To do this, connect via ssh to one of the two instances and type the command below: `stress -c 8`
