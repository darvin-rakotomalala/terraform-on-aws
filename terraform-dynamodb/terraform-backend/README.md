## DynamoDB with Terraform

In this repository, I’ll show a basic example of how to create and manage DynamoDB tables using Terraform.

### Why Use S3 and DynamoDB?

- **S3**: Durable storage for Terraform state files.
- **DynamoDB**: Provides state locking to prevent simultaneous updates.

### Why Do We Need a Backend?

A Terraform backend is crucial for managing the state and ensuring consistent deployments, especially in collaborative environments. Here’s why:

1. **State Management**: Terraform uses a state file to keep track of the resources it manages. By default, this state is stored locally, but this approach is risky

   - **Local State Loss**: If the local state file is lost or corrupted, the current state of your infrastructure is lost.
   - **Collaboration Issues**: In a team, local state makes it challenging to coordinate changes, as each member would have a different view of the infrastructure.

2. **Remote State**: Storing the state remotely (e.g., in an S3 bucket) ensures:

   - **Consistency**: Everyone on the team has access to the same state, preventing conflicts and discrepancies.
   - **Durability**: The state file is stored securely, with automatic backups and versioning.

3. **State Locking**: Using a DynamoDB table for state locking prevents simultaneous operations that could lead to state corruption:

   - **Concurrent Operations**: If two team members or processes try to apply changes at the same time, state locking ensures only one operation proceeds at a time.
   - **Integrity**: This mechanism preserves the integrity of the state file, avoiding race conditions and partial updates.

### The Challenge

Terraform needs the S3 bucket and DynamoDB table to manage its state and lock files. But these resources need to exist before Terraform can configure them as its backend, follow the sequence:

- 1. Define and apply the configuration without backend settings.
- 2. After creating S3 and DynamoDB manually through Terraform, update the configuration to use the backend.
- 3. Reinitialize and apply again.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
