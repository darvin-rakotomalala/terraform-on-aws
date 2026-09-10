## Creating AWS DynamoDB Table Using Terraform

In this repository, I’ll show a basic example of how to create AWS DynamoDB Table Using Terraform and managing Data with AWS DynamoDB.

### Basic concepts

- The **name** parameter determines the identifier for our table in DynamoDB. Much like naming files in a filesystem, this uniquely labels our table for easy reference.
- **billing_mode** tells AWS whether to provision a fixed capacity for our table ("PROVISIONED") or scale it dynamically based on usage ("PAY_PER_REQUEST"). This impacts billing and scalability.
- **Read and Write capacity units** directly control the throughput performance of our table. This allocates the read and write throughput to suit our application's traffic needs.
- The **hash and range keys** are critical because they define the underlying organization for data in the table. This models the primary access patterns that our application requires.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
