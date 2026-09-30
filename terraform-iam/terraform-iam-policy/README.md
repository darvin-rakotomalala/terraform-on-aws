## Create AWS IAM Policy with Terraform

In this repository I’ll show an example how to create AWS IAM Policy using Terraform.

IAM policies lie at the heart of AWS access management. Essentially, they are a set of permissions that can be attached to an AWS identity or resource to manage its access.

**Different ways of representing IAM policies in Terraform**

Terraform provides multiple ways to represent a policy in HCL. These are:

- `HEREDOC` syntax
- `jsonencode` function to convert a policy into JSON
- `file` function to load a policy from a JSON file
- ``aws_iam_policy_document` data resource(recommended because it allows Terraform to validate any errors without having to apply the changes)

### STEPS

- Step 1: Create **provider.tf**, **iam_policy.tf**.
- Step 2: Run the below command
- Step 3: Go to the AWS console and verify

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.

### Best practices for managing IAM policies in Terraform

- **_Follow the principle of least privilege_** — Grant only the minimum permissions required to perform specific tasks, avoiding `"*"` (wildcard) permissions whenever possible.
- **_Use IAM roles instead of direct user attachments_** — Attach IAM policies to roles rather than users, enabling better access control and making it easier to manage permissions across multiple entities.
- **_Leverage JSON encoding (`jsonencode()`) for policy definitions_** — Using `jsonencode()` ensures cleaner, more maintainable Terraform code compared to hardcoded JSON strings.
- **_Store policies in separate modules or files_** — To improve code organization and reusability, keep IAM policies modular by storing them in separate `.tf` files or Terraform modules.
- **_Use AWS-managed policies when applicable_** — Favor AWS-managed policies for common use cases to reduce maintenance overhead and benefit from AWS security updates.
