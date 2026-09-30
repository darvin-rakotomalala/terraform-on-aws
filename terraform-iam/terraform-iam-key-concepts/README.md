## Deploy AWS IAM Users, User Groups, Policies and Roles Using Terraform

In this repository I’ll show an example how to deploy AWS IAM Users, User Groups, Policies and Roles Using Terraform.

### Key components of AWS IAM

- IAM USER
- IAM GROUP
- IAM POLICY
- IAM ROLE

### STEPS

- Deployment Process
  - Creating an IAM User
  - Creating an IAM Group
  - Attaching an AWS Managed Policy
  - Creating a Custom IAM Policy
  - Creating a New IAM Role
- Step 1: Create **provider.tf** and **iam.tf**.
- Step 2: Run the below command
- Step 3: Go to the AWS console and verify - IAM User, User Group, Group Permissions, User Permissions, Role and policy

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
