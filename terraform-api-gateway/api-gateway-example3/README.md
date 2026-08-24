## Deploying a Serverless Architecture with REST API using API Gateway, Lambda, DynamoDB, and Terraform

In this repository, we'll show how to create an API hosted on API Gateway, with AWS Lambda handling the backend logic and DynamoDB serving as the database. The Lambda function will implement CRUD operations (Create, Read, Update, Delete) on the DynamoDB table. This serverless architecture ensures scalability, cost-effectiveness, and ease of maintenance using Terraform.

### Steps

- Create Lambda IAM Role
- Setup lambda code - serves as the backend for a REST API, handling CRUD operations on a DynamoDB table.
- Create a Lambda Function
- Setup DynamoDB Table
- Setup API Gateway - The API Gateway functions as a proxy, forwarding incoming HTTP requests from the client to the Lambda function using a POST request.
  - We want following API endpoints or Methods:
  - GET /books: Retrieve the list of all books.
  - GET /book/{book_id}: Retrieve details of a specific book by its id.
  - POST /book: Add a new book to the database.
  - PATCH /book/{book_id}: Update the details of a specific book using its id.
  - DELETE /book/{book_id}: Delete a book from the database using its id.
- Run Terraform
- Testing verify on console
- Testing using Postman
-  Cleanup - Remember to stop AWS components to avoid large bills.

### Key concepts

- `Method Request`: Defines the HTTP method (GET, POST, PATCH, DELETE) for the API Gateway.
- `Integration Request`: Connects the API Gateway to the Lambda function, allowing it to process requests.
- `Integration Response`: Defines how the Lambda function's response is processed and returned to the client.
- `Method Response`: Specifies the response format and headers expected from the API Gateway.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
