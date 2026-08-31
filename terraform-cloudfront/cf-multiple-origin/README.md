## Create an AWS CloudFront with Multiple Origin Cache Behavior using Terraform

In this repository, I’ll show an example how to implement AWS CloudFront with Multiple Origin Cache Behavior using Terraform.

CloudFront's multiple origin cache behavior allows you to configure a single CloudFront distribution to fetch content from different origins based on specified conditions. This capability is particularly useful when you need to serve content from multiple sources (such as different S3 buckets or custom origins) through a single CloudFront distribution efficiently.

Multiple origin cache behavior in AWS CloudFront enables a single CloudFront distribution to fetch content from multiple origins based on rules you define. This allows you to consolidate content delivery from various sources, optimizing network latency and improving content availability. By configuring cache behaviors, you can specify which requests CloudFront forwards to which origin, based on request path patterns, headers, query strings, or any combination thereof.

### Steps

- Create primary and secondary S3 static websites
- Create CloudFront distribution with default and path-pattern based cache behavior
- Create S3 bucket policy to allow access from CloudFront

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
