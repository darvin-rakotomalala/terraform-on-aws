## Deploying a CloudFront distribution for S3 Static Website using Terraform

In this repository, I’ll show an example how to integrate Amazon Content Delivery Networks (CDNs) CloudFront with websites hosted on S3 bucket using Terraform.

**What is CloudFront?**

Amazon CloudFront is a web service that speeds up distribution of your static and dynamic web content, such as .html, .css, .js, and image files, to your users. CloudFront delivers your content through a worldwide network of data centers called edge locations. When a user requests content that you're serving with CloudFront, the request is routed to the edge location that provides the lowest latency (time delay), so that content is delivered with the best possible performance.

If the content is already in the edge location with the lowest latency, CloudFront delivers it immediately.

If the content is not in that edge location, CloudFront retrieves it from an origin that you've defined—such as an Amazon S3 bucket, a MediaPackage channel, or an HTTP server (for example, a web server) that you have identified as the source for the definitive version of your content.

CloudFront speeds up the distribution of your content by routing each user request through the AWS backbone network to the edge location that can best serve your content.

### Steps

- Create an S3 bucket with a unique name and host the static website by uploading files'
- Configure a CloudFront distribution to serve as the CDN for our website
- Update the S3 Bucket policy to allow access from CloudFront
- Run Terraform
- Testing the outcome
- Cleanup

**Notes**

- Cache Invalidation can be forced from console for a cloudfront distribution
- Deprecated Origin Access Identity OAI also can be used instead of Origin Access Control OAC

Incorporating Amazon CloudFront into our static website architecture significantly enhances performance and improves user experience.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
