## Terraform Remote State Storage and State Locking with AWS S3 and DynamoDB

Remote backends are essential for managing your Terraform state files in a collaborative environment. Terraform Cloud offers a managed solution, while self-managed backends like AWS S3 provide more control and customization.

**Self-managed Backend (AWS S3):**

- Specify an S3 bucket and a DynamoDB table in the Terraform configuration
- S3 bucket stores the state file, while the DynamoDB table prevents multiple concurrent apply commands
- Requires a bootstrapping process to provision the S3 bucket and DynamoDB table

**Bootstrapping Process for AWS S3 Backend:**

- Create a Terraform configuration without a remote backend (defaults to a local backend)
- Define the necessary AWS resources: S3 bucket and DynamoDB table with a hash key named **"LockID"**
- Run **terraform apply** to create the S3 bucket and DynamoDB table
- Update the Terraform configuration to use the remote backend with the S3 bucket and DynamoDB table
- Re-run **terraform init** to import the state into the new remote backend

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed
