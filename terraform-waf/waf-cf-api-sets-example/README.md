## Setting Up WAF for CloudFront using IP Sets and Terraform

In this repository, I’ll show a basic example of how to set up WAF for CloudFront using IP Sets and Terraform.

Amazon CloudFront is a content delivery network (CDN) that distributes your content with low latency and high transfer speeds. By associating a WAF with a CloudFront distribution, you can protect your web applications from common web exploits and vulnerabilities. An IP set, a key component of WAF, allows you to specify a list of IP addresses that are allowed or blocked. This is particularly useful for:

- Restricting access to your applications from known office or VPN IP addresses.
- Blocking traffic from suspicious IP addresses to enhance security.

**Key Components of WAF**

- WAF ACL (Access Control List): The ACL is the top-level component that houses the WAF rules.
- WAF Rules: These rules determine the actions to be taken (e.g., ALLOW, BLOCK, COUNT).
- WAF Sets: Collections of rule sets, such as IP sets, specified for matching against incoming requests.
- WAF Association: Defines which resources the WAF is associated with.

**Example WAF Configuration**

In this example, we have a WAF configuration designed to allow traffic only from known (or approved) IP addresses and block all other requests. The configuration is as follows:

- **Rule 1 (Allow List)**: Allows requests from IPs listed in the approved IP list, ensuring that only traffic from known sources can access the network.
- **Default Action**: Block all other requests that do not match Rule 1, thereby providing a baseline security posture.
- **Custom Response for Blocked IPs**: A custom HTML response indicating unauthorised access.
- **Visibility Configurations**: Optional settings to enable WAF to push metrics to CloudWatch for better monitoring and anomaly detection.
- **Provider**: As we’re attaching the WAF to a CloudFront Distribution, the provider for the IP set and WAF must be set to us-east-1.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
