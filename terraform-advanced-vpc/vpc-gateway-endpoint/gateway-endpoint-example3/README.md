## Creating VPC Gateway Endpoint to connect to S3 over AWS PrivateLink with Terraform

In this repository, I'll show you how to create a VPC Gateway Endpoint to connect to S3 over AWS PrivateLink with Terraform, particularly focusing on connecting to Amazon S3.

### Steps

- Create a VPC
- Establish IAM Role with Policy and Instance Profile for S3 Access 
- Deploy Bastion and Private Host with Instance Profile
- Provision an S3 Bucket 
- Create a VPC Gateway Endpoint Connected to the Private Route Table 
- Run Terraform
- Testing the outcome
  - Accessing S3 bucket from private host via gateway endpoint
-  Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
