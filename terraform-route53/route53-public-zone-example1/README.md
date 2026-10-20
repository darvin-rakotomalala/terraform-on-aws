## Create AWS Route 53 using Terraform

In this repository, I’ll show a basic example of how to create AWS Route 53 Using Terraform.

**What is AWS Route 53?**

Route 53 is Amazon Web Services' exceptionally adaptable and available Domain Name System (DNS) web service. It gives developers and administrators the ability to manage domain names and route internet traffic to different AWS resources and different endpoints.

Public hosted zones in Route 53 are designed to host public domains and can be reached from any location on the Internet. Typically, these zones are employed to direct traffic to public websites and other resources accessible publicly.

**Key features of Route 53 include:**

- **Domain Registration**: Route 53 allows users to register and manage domain names directly through the service. By using Route 53 users can create their own domain name easily.
- **DNS Management**: Users can create and manage DNS records, for example, A, AAAA, CNAME, MX, TXT, and so on. to map domain names to specific IP addresses or other DNS records.
- **Traffic Routing**: Route 53 backings different routing arrangements, including simple routing, weighted routing, dormancy based routing, geolocation-based routing, and failover routing. These approaches empower clients to control how traffic is coordinated to various endpoints in light of elements like geographic area, latency, or health checks.
- **Health Checking**: Route 53 incorporates wellbeing really looking at capacities to screen the wellbeing and accessibility of endpoints. Clients can arrange wellbeing checks to screen the situation with their resources and consequently change steering in view of the outcomes.
- **Worldwide Reach**: With a distributed network of DNS servers found around the world, Route 53 ensure low-latency and high execution DNS resolution for users getting to resources internationally.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
