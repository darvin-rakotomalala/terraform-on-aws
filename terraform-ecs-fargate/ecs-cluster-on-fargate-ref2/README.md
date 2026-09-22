## Creating AWS ECS Infrastructure with Terraform

In this repository, I’ll show a basic example of how to create AWS ECS Infrastructure with Terraform.

### Project Structure

```
Terraform
├── alb.tf                --> ALB, listener, target group
├── auto-scaling.tf       --> ECS autoscaling policies and alarms
├── backend.tf            --> S3 + DynamoDB backend for remote state
├── ecr.tf                --> ECR repository and lifecycle policy
├── ecs.tf                --> ECS cluster, task definition, service
├── iam.tf                --> IAM roles for ECS and autoscaling
├── logs.tf               --> CloudWatch log group/stream
├── network.tf            --> VPC, subnets, routing, NAT, IGW
├── provider.tf           --> AWS provider config
├── security.tf           --> Security groups for ALB and ECS tasks
├── variables.tf          --> Actual values for variables
├── terraform.tfvars      --> All required input variables
```

### Steps

- Configure Terraform Backend
- Configure Provider & Input Variables
- Networking
- Security Groups
- Logging
- IAM Roles
- ECR Repository
- ECS Cluster, Task, and Service
- Application Load Balancer
- Auto Scaling
- Deploy Terraform
- Push Docker Image to ECR
- Verify

Everything in Terraform happens with six simple steps:

- Initialize Terraform (downloads providers & sets up backend)
  `terraform init`

- Validate configuration
  `terraform validate`

- Preview the changes
  `terraform plan -var-file="terraform.tfvars"`

- Apply the changes (creates infrastructure)
  `terraform apply -var-file="terraform.tfvars" -auto-approve`
