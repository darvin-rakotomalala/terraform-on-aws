## Using S3 with Terraform

In this project, we will learn how to create and manage S3 buckets in AWS.

**What's AWS S3?**
Amazon S3 (Simple Storage Service) is an object storage service that allows you to store and retrieve large amounts of unstructured data from anywhere on the web. With S3, you can store various types of unstructured data, such as videos, images, audio files, and any other type of data that doesn't fit neatly into a database.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
