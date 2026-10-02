## Creating an AWS KMS using Terraform

In this repository, I’ll show a basic example of how to create a KMS key using Terraform.

### Best Practices for KMS Usage

**1 — Key Rotation**

- Enable automatic key rotation as we did in our configuration
- Consider using different keys for different environments

**2 — Access Control**

- Implement least-privilege access in your key policies
- Use separate keys for different applications or services

**3 — Monitoring**

- Enable AWS CloudTrail to audit KMS key usage
- Set up alerts for unauthorized access attempts

**4 — Security**

- Never store unencrypted sensitive values in version control
- Use separate key aliases for different environments
- Implement proper backup and recovery procedures

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
