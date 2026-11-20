<div align="center">

# 🚀 Terraform on AWS

**A hands-on learning journey: building real AWS infrastructure with Infrastructure as Code**

![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazonaws&logoColor=white)
![Projects](https://img.shields.io/badge/Projects-37-blue)
![Status](https://img.shields.io/badge/Status-Learning%20in%20progress-brightgreen)
![License](https://img.shields.io/badge/Purpose-Educational-lightgrey)

</div>

---

## 📖 About This Repository

This repository is my personal **Terraform learning lab on AWS**. Each folder is a small, focused project that explores
one AWS service or one Terraform concept, from the basics (an EC2 instance, an S3 bucket) to more advanced architectures
(multi-tier VPCs, ECS Fargate, disaster recovery strategies).

The goal is simple: **learn by building**. Every project is written, deployed, tested and destroyed so that the concepts
stick, and so that the code can serve as a reference for future real-world work.

> ⚠️ **Educational purpose only.** These projects are designed for learning and experimentation, not as production-ready
> modules without review.

---

## 🎯 Learning Objectives

- Master **Terraform fundamentals**: providers, resources, variables, outputs, locals, data sources, modules and state.
- Understand how to **design and provision AWS infrastructure** as code in a repeatable and version-controlled way.
- Practice **security best practices**: IAM least privilege, encryption with KMS, secrets management, WAF, CloudTrail
  and VPC Flow Logs.
- Build **highly available, scalable and resilient architectures** using load balancers, auto scaling, multi-AZ
  databases and DR strategies.
- Learn how to **manage remote state, workspaces and environments** safely.
- Explore **serverless and event-driven** patterns with Lambda, API Gateway, EventBridge, SNS and SQS.
- Develop good habits: clean structure, naming conventions, reusable code and clear documentation.

---

## 🗂️ Projects Overview

The repository contains **37 projects**, grouped below by theme.

### 🏗️ Terraform Foundations

| Project                                              | Objective                                                                                  |
|------------------------------------------------------|--------------------------------------------------------------------------------------------|
| [`terraform-s3-backend`](./terraform-s3-backend)     | Store Terraform state remotely in S3 with locking, for safe team-friendly workflows.       |
| [`terraform-workspace`](./terraform-workspace)       | Manage multiple environments (dev, staging, prod) with Terraform workspaces.               |
| [`terraform-data-sources`](./terraform-data-sources) | Query existing AWS resources (AMIs, VPCs, AZs, accounts) and reuse them in configurations. |

### 🖥️ Compute

| Project                                              | Objective                                                                                       |
|------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| [`terraform-ec2-instance`](./terraform-ec2-instance) | Launch and configure a basic EC2 instance.                                                      |
| [`terraform-ec2-server`](./terraform-ec2-server)     | Deploy a complete server (security groups, key pairs, user data) ready to serve an application. |
| [`terraform-ami-ec2`](./terraform-ami-ec2)           | Create custom AMIs and launch instances from them.                                              |
| [`terraform-autoscaling`](./terraform-autoscaling)   | Scale EC2 capacity automatically with Auto Scaling Groups and launch templates.                 |
| [`terraform-ecs-fargate`](./terraform-ecs-fargate)   | Run containerized applications on ECS with Fargate, without managing servers.                   |
| [`terraform-lambda`](./terraform-lambda)             | Deploy serverless functions and their execution roles.                                          |

### 🌐 Networking & Content Delivery

| Project                                                | Objective                                                                               |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------|
| [`terraform-vpc`](./terraform-vpc)                     | Build a VPC from scratch: subnets, route tables, internet gateway and NAT.              |
| [`terraform-advanced-vpc`](./terraform-advanced-vpc)   | Design a multi-AZ, multi-tier network with public, private and database subnets.        |
| [`terraform-vpc-template`](./terraform-vpc-template)   | Create a reusable VPC template/module that can be applied across projects.              |
| [`terraform-vpc-asg-lb`](./terraform-vpc-asg-lb)       | Combine VPC, Auto Scaling and Load Balancer into a complete, scalable web architecture. |
| [`terraform-vpc-flow-logs`](./terraform-vpc-flow-logs) | Capture and analyze network traffic with VPC Flow Logs.                                 |
| [`terraform-load-balancer`](./terraform-load-balancer) | Distribute traffic across targets with Application/Network Load Balancers.              |
| [`terraform-route53`](./terraform-route53)             | Manage DNS zones, records and routing policies.                                         |
| [`terraform-cloudfront`](./terraform-cloudfront)       | Accelerate content delivery with a CDN in front of S3 or a load balancer.               |
| [`terraform-acm`](./terraform-acm)                     | Provision and validate SSL/TLS certificates with AWS Certificate Manager.               |
| [`terraform-api-gateway`](./terraform-api-gateway)     | Expose REST/HTTP APIs and integrate them with backend services.                         |

### 💾 Storage & Backup

| Project                                        | Objective                                                                           |
|------------------------------------------------|-------------------------------------------------------------------------------------|
| [`terraform-s3`](./terraform-s3)               | Create S3 buckets with versioning, encryption, lifecycle rules and access policies. |
| [`terraform-ebs`](./terraform-ebs)             | Provision and attach block storage volumes to EC2 instances.                        |
| [`terraform-efs`](./terraform-efs)             | Set up shared, elastic file systems mountable by multiple instances.                |
| [`terraform-awsbackup`](./terraform-awsbackup) | Automate backup plans, vaults and retention policies with AWS Backup.               |

### 🗄️ Databases

| Project                                      | Objective                                                                              |
|----------------------------------------------|----------------------------------------------------------------------------------------|
| [`terraform-rds`](./terraform-rds)           | Deploy managed relational databases with subnet groups, parameter groups and Multi-AZ. |
| [`terraform-aurora`](./terraform-aurora)     | Build high-performance Aurora clusters with writer and reader instances.               |
| [`terraform-dynamodb`](./terraform-dynamodb) | Create NoSQL tables with keys, indexes, capacity modes and TTL.                        |

### 🔐 Security, Identity & Compliance

| Project                                          | Objective                                                                      |
|--------------------------------------------------|--------------------------------------------------------------------------------|
| [`terraform-iam`](./terraform-iam)               | Manage users, groups, roles and policies following least privilege.            |
| [`terraform-kms`](./terraform-kms)               | Create and manage encryption keys, aliases and key policies.                   |
| [`terraform-sm`](./terraform-sm)                 | Store and retrieve sensitive values securely (secrets management).             |
| [`terraform-cognito`](./terraform-cognito)       | Add authentication and user management with user pools and identity providers. |
| [`terraform-waf`](./terraform-waf)               | Protect web applications with WAF rules and managed rule groups.               |
| [`terraform-cloudtrail`](./terraform-cloudtrail) | Enable auditing and governance by logging API activity across the account.     |

### 📊 Monitoring & Event-Driven Messaging

| Project                                            | Objective                                                                    |
|----------------------------------------------------|------------------------------------------------------------------------------|
| [`terraform-cloudwatch`](./terraform-cloudwatch)   | Set up metrics, log groups, alarms and dashboards for observability.         |
| [`terraform-eventbridge`](./terraform-eventbridge) | Build event-driven workflows with rules, schedules and targets.              |
| [`terraform-sns`](./terraform-sns)                 | Publish notifications to topics with email, SMS and application subscribers. |
| [`terraform-sqs`](./terraform-sqs)                 | Decouple services with standard/FIFO queues and dead-letter queues.          |

### 🛟 Resilience

| Project                                                | Objective                                                                                       |
|--------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| [`terraform-dr-strategies`](./terraform-dr-strategies) | Explore disaster recovery approaches (Backup & Restore, Pilot Light, Warm Standby, Multi-Site). |

---

## 🧰 Tech Stack

| Technology            | Usage                                             |
|-----------------------|---------------------------------------------------|
| **Terraform (HCL)**   | Infrastructure as Code, the core of every project |
| **AWS**               | Target cloud platform                             |
| **Python**            | Lambda functions and automation scripts           |
| **Shell**             | User data and helper scripts                      |
| **HTML / JavaScript** | Sample web content and application demos          |
| **Docker**            | Containerized workloads for ECS Fargate           |

---

## ✅ Prerequisites

- An **AWS account** (the Free Tier is enough for many projects)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) `>= 1.5`
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured with credentials
  (`aws configure`)
- Git

---

## ⚡ Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/darvin-rakotomalala/terraform-on-aws.git
cd terraform-on-aws

# 2. Choose a project
cd terraform-s3

# 3. Initialize, review and apply
terraform init
terraform plan
terraform apply

# 4. Clean up to avoid unnecessary costs
terraform destroy
```

---

## 📁 Typical Project Structure

```text
terraform-<service>/
├── main.tf          # Core resources
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── providers.tf     # Provider and version constraints
└── terraform.tfvars # Variable values (not committed if sensitive)
```

---

## 💡 Best Practices Applied

- 🔒 Never commit secrets, credentials or `.tfstate` files
- 🏷️ Consistent naming and tagging of resources
- 🧩 Variables and outputs for flexibility and reuse
- 🌍 Remote state with locking for collaboration
- 📌 Pinned provider and Terraform versions
- 🧹 Always run `terraform destroy` after experimenting

---

## 💰 Cost Warning

Some resources (NAT Gateways, RDS/Aurora, ECS, load balancers, WAF, CloudFront, etc.) **are not free** and can generate
charges quickly. Always:

1. Review the output of `terraform plan` before applying.
2. Destroy resources when you are done.
3. Set up an **AWS Budget alert** on your account.
