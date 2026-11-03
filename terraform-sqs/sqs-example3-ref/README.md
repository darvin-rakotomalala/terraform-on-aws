## Setting up AWS SQS with Terraform

This guide shows a basic example how to deploy Amazon Simple Queue Service (SQS) using Terraform Infrastructure as Code.

Amazon Simple Queue Service (SQS) is a fully managed message queuing service provided by AWS. With SQS, messages can be
stored and retrieved from queues ensuring reliable delivery.

It enables reliable and scalable communication between various components of distributed systems, allowing decoupling of
applications and asynchronous processing of messages.

### Best Practices

- **Queue Management**
    - Use meaningful queue names
    - Implement proper access controls
    - Configure appropriate timeout values
    - Use FIFO queues when message order matters

- **Security**
    - Implement least privilege access
    - Use encryption for sensitive data
    - Regularly audit queue policies
    - Monitor failed message deliveries

- **Reliability**
    - Implement proper error handling
    - Use DLQ for failed messages
    - Monitor queue depth
    - Implement proper retry policies

- **Cost Optimization**
    - Monitor message volume
    - Clean up unused queues
    - Use long polling when appropriate
    - Consider message batching

This setup provides a comprehensive foundation for deploying SQS using Terraform. Remember to:

- Plan your messaging architecture carefully
- Implement proper security measures
- Monitor queue metrics and DLQ
- Keep your configurations versioned
- Test thoroughly before production deployment

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
