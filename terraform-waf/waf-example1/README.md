## Deploying AWS WAF with Terraform

In this repository, I’ll show a basic example of how to deploy AWS WAFv2 with Terraform.

AWS Web Application Firewall (WAF) is a service that helps protect web applications from attacks by allowing you to block malicious traffic before it reaches your servers.

- **AWS WAF Classic**: This is the original version of AWS WAF. It allows us to protect our AWS applications and APIs against common web exploits such as SQL injection, Cross-Site Scripting (XSS), etc. We can use AWS WAF Classic to create custom rules that block or allow requests based on conditions like IP addresses, HTTP headers, HTTP body, or URI strings.
  <br>
- **AWS WAFv2**: This is the newer version of AWS WAF, released in November 2019. It includes several enhancements over the Classic version. For instance, it has a simpler pricing model, it’s easier to deploy and manage, and it provides improved customizability over how we inspect and filter web requests. AWS WAFv2 also integrates better with other AWS services, and it provides features such as managed rule groups and tagging.
  <br>
- _If you’re using AWS WAF with Amazon CloudFront, the scope is **“CLOUDFRONT”**, and AWS WAF protects and logs all requests from all AWS Regions._
  <br>
- _If you’re using AWS WAF with a regional application — an Application Load Balancer, Amazon API Gateway, or AWS AppSync — the scope is **“REGIONAL”**. If you’re associating WAF with regional services such as Application Load Balancer (ALB) or API Gateway, the WAF ACL has to be in the same region as these services._

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
