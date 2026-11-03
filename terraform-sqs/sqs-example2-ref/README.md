## Create AWS SQS Queues with Terraform

This guide shows a basic example how to define and configure an Amazon SQS queue using Terraform.

**Amazon SQS** is a lightweight, fully-managed message queuing service. We can use SQS to decouple and scale
microservices, serverless applications, and distributed systems. SQS makes it easy to store, receive, and send messages
between software components.

**Example 1: Production queue with custom behavior**
In a production environment, you usually want:

- A main queue for normal messages
- A dead letter queue (DLQ) for messages that keep failing
- Sensible timeouts and retention settings

**Example 2: Secure encrypted queue for sensitive data**
You can create a secure, encrypted SQS queue in Terraform by combining three things: the queue itself, a KMS key for
encryption, and an optional queue policy that controls who can send and receive messages.

**Example of a FIFO Queue**
A FIFO SQS queue guarantees that messages are processed in the exact order they are sent and that they are processed
only once.

The key points are:

- The queue name must end with ```.fifo```
- You must enable ```fifo_queue = true```
- For higher throughput you typically enable ```content_based_deduplication```

**Permissions and access control**
Create a dedicated IAM role for each consumer/producer service and grant only the actions it needs:

- Producers: usually ```sqs:SendMessage```, ```sqs:GetQueueAttributes```.
- Consumers: ```sqs:ReceiveMessage```, ```sqs:DeleteMessage```, ```sqs:ChangeMessageVisibility```,
  ```sqs:GetQueueAttributes```.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
