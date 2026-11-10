## Deploy a Highly Available Group of EC2 Instances Using Terraform

In this project, we'll learn how to deploy a highly available group of EC2 Instances using Terraform, load balancer and autoscaling group.

**High availability (HA)** refers to the continuous availability of your application and data regardless of any downtime. In other words, if your web application is available 24/7 to serve your customers or clients without any downtime, it’s called a highly available web app.

**High Scalability** refers to the ability of an application or a system to handle a huge volume of workload or expand in response to an increased demand for an application. For example, suppose you have an online shopping website running on a fleet of ten web servers and you plan for a discount sale. This sale will be going to increase the workload on your servers. So you anticipate the network traffic and you add 5 more servers to host your shopping website and avoid any downtime. Which means you have scaled your infrastructure. This ability of your application to scale is called high scalability. So the more scalable your application the more available it’s. So high scalability and high availability are correlated but not the same.

### Architecting our application

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
