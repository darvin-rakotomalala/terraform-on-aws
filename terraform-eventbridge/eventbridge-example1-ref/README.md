## Setting up AWS EventBridge using Terraform

This guide shows a basic example how to create an AWS EventBridge using Terraform.

**How does EventBridge work?**

Amazon EventBridge operates using four main concepts:

- **Events** – Events are the messages that describe a change or an occurrence, like a file being uploaded to an S3
  bucket or a DynamoDB record change.
- **Event sources** – Event sources are the systems that emit an event, like an AWS service, a supported third-party
  application, or your API/application. You can publish custom events to the event bus via the EventBridge API or SDK.
- **Event buses**  – Event buses are the central hub for events. Each event bus receives events from specific sources
  and forwards them to the appropriate targets. EventBridge already has a default event bus available.
- **Targets** – Targets are the destination of the event. AWS Services (Lambda, SQS, SNS, other Event Buses), HTTP
  Endpoints, or third-party services.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
