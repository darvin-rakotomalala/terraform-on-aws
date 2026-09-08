## Terraform Data Sources example

**Data sources** in Terraform are used to get information about resources external to Terraform, and use them to set up
your Terraform resources. For example, a list of IP addresses a cloud provider exposes. Data sources serve as a bridge
between the current infrastructure and the desired configuration, allowing for more dynamic and context-aware
provisioning.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed
