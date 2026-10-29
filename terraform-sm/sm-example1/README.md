## Using AWS Secrets Manager for Terraform secrets

In this repository, I’ll show a basic example of how to store our database credentials in the AWS Secrets Manager with Terraform.

One advantage of using the secrets_manager data source in Terraform is that it automatically marks these values being read as sensitive. Thus, the CLI output or state files do not expose the secrets.

**Managed Secrets Characteristics**
Managed secrets provided by AWS services include:

- Automated creation and lifecycle management
- Built-in rotation capabilities
- Protection against accidental modifications
- Required recovery period for deletions
- Service-specific access controls

**Best Practices**
**1. Secret Organization**
— Use hierarchical naming for secrets (e.g., /env/service/secret)
— Tag secrets for better organization and cost allocation
— Use separate secrets for different environments

**2. Access Control**
— Implement least-privilege access using IAM policies
— Use resource-based policies for cross-account access
— Regularly audit secret access using CloudTrail

**3. Rotation**
— Enable automatic rotation for supported secret types
— Implement custom rotation functions for application-specific secrets
— Test rotation procedures in non-production environments

**4. Security**
— Enable encryption at rest using KMS keys
— Use VPC endpoints for secure access
— Implement proper backup and recovery procedures

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
