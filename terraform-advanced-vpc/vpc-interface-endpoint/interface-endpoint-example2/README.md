## Creating and Linking VPC Endpoint of Type Interface using Terraform

In this repository, I’ll show a basic example of how to create and link a VPC endpoint of type Interface using. Creating and linking an AWS Interface VPC Endpoint with Terraform involves several steps: defining the endpoint, creating a security group to control access, and enabling private DNS resolution to use the service's default public DNS names.

_Nb: Route Table Association (Not required for interface endpoints)_

### Steps to Create a VPC Endpoint of Type Interface

- **Create Security Groups for Lambda and DynamoDB:**

  - For the DynamoDB Security Group, specify an inbound rule that accepts incoming requests from the Lambda Security Group.
  - For the Lambda Security Group, specify an outbound rule that permits sending requests to DynamoDB.

- **Create the VPC Endpoint:**
  - Choose the Interface type service, select the private subnet ID, and link your DynamoDB Security Group to it.
  - After creating the VPC Endpoint, retrieve the DNS name from the description, and use it in your Lambda code to connect to DynamoDB.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.

_You can use this endpoint like this in your Node.js Lambda function:_

```
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const client = new DynamoDBClient({
    endpoint: `https://<THE VPC ENDPOINT DNS>`,
});
const dynamoDbClient = DynamoDBDocumentClient.from(client);

```
