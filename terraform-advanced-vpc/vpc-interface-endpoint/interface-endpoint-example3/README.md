## AWS Networking VPC Interface Endpoint with Terraform

In this repository, I’ll show a basic example of how to create VPC Interface Endpoint with Terraform. Specifically, we'll focus on leveraging VPC Interface Endpoints to connect to an essential AWS service - the Simple Queue Service (SQS).

### Interface endpoints

**Interface endpoints** enable connectivity to services over AWS PrivateLink. An interface endpoint is a collection of one or more elastic network interfaces with a private IP address that serves as an entry point for traffic destined to a supported service. Interface endpoints support many AWS managed services.

### Steps

- Create a VPC
- Set up IAM Role
- Deploy Bastion and Private Host
- Create SQS Queue
- Configure VPC Interface Endpoint
- Steps to Run Terraform
- Testing the outcome
  - Listing SQS queues via Interface Endpoint
  - Send a message to SQS
  - Receive Message from SQS
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
