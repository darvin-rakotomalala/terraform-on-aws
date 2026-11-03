## Creating an SQS Queue using Terraform

This guide shows a basic example how to create an SQS Queue using Terraform.

Amazon Simple Queue Service (SQS) is a fully managed message queuing service provided by AWS. With SQS, messages can be
stored and retrieved from queues ensuring reliable delivery.

It enables reliable and scalable communication between various components of distributed systems, allowing decoupling of
applications and asynchronous processing of messages.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
