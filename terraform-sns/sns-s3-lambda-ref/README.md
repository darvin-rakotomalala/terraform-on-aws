## Amazon S3-SNS-Lambda with Terraform

In this repo, we’ll learn how to build a production-ready, event-driven file-processing system using Amazon Simple
Storage Service (S3), Amazon Simple Notification Service (SNS), AWS Lambda, and AWS CloudWatch, with Terraform
automation. The architecture leverages AWS Key Management Service (KMS) for customer-managed encryption, structured
logging, and enterprise-grade security controls, creating a fully automated pipeline that scales with demand.

**The event-driven workflow follows this sequence:**

1. File uploaded to an Amazon S3 bucket triggers an event notification
2. Amazon SNS receives the notification with file metadata and event details
3. An AWS Lambda function processes the event payload and extracts file information
4. Amazon CloudWatch log captures structured logs for monitoring and troubleshooting

**This high-level objective is further broken down into five implementation stages:**

- Stage 1: AWS KMS Encryption Setup for all services
- Stage 2: Amazon S3 Bucket Configuration with event notifications
- Stage 3: Amazon SNS Topic and AWS Lambda Integration
- Stage 4: Amazon CloudWatch Logging and Monitoring
- Stage 5: GitHub Actions Automation

**Test:**

- Upload a test file
- Verify processing in CloudWatch Logs
- Monitor performance metrics

The solution demonstrates how **modern cloud-native patterns** can deliver enterprise-grade capabilities while
maintaining operational simplicity and cost efficiency.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
