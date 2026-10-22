## Create and Manage an AWS S3 Bucket Using Terraform - Example

In this project, we will learn how to create and manage S3 buckets in AWS. This project is all about managing the AWS S3 bucket using Terraform. Terraform provides three S3 resources:

- Using aws_s3_bucket resource to create S3 Bucket.
- Uploading files to S3 bucket using aws_s3_bucket_object.
- Managing ACL (Access Control List) using aws_s3_bucket_public_access_block.
- Create an S3 bucket policy that allows read-only access to a specific IAM user or role.

**What's AWS S3?**
Amazon S3 Bucket is a storage service offered by AWS for storing data lakes, websites, mobile applications, backup and restore, archive, enterprise applications, etc. The S3 stands for Simple Storage Service which can be scaled based on individual or organization needs.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
