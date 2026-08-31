## Deploying a website on AWS using Terraform

In this repository, I’ll show an example how to to upload a website to AWS S3 and set it as the origin of a CloudFront distribution using Terraform.

### Steps

- Creating an S3 bucket
- Configuring the website on S3
- Setting up CloudFront
- Implementing cache invalidation
- Testing the website in a browser

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
