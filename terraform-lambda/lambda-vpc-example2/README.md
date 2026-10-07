## Configuring a Lambda Function in a VPC to access external API with Terraform

In this repository, I’ll create a basic example of how to configure a Lambda Function in a VPC to access external API via NAT Gateway and Store in DynamoDB using AWS PrivateLink with Terraform.

AWS Lambda functions running inside a Virtual Private Cloud (VPC) provide enhanced security, network isolation, and direct access to other AWS services within the VPC. By placing Lambda in a VPC, we ensure it can securely communicate with private resources like databases while also accessing external APIs via a NAT Gateway. This setup is crucial for workloads that require controlled outbound internet access and private service interactions.

### Steps

- Create a VPC with Public and Private Subnets
- Create a DynamoDB Table
- Create a VPC Interface Endpoint for DynamoDB
- Create IAM Role for Lambda
- Create a Lambda Function
- Create cloudwatch log group for logging
- Run Terraform
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
