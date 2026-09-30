## Create AWS IAM Roles Using Terraform

In this repository I’ll show an example how to create AWS IAM Roles using Terraform.

IAM Role is mainly used in these scenarios :

- To **grant permissions** to AWS services such as EC2 , Lambda , etc.
- **To enable cross account access** for sharing resources.
- **Temporary permissions** for applications and services running on AWS infrastructure.

For example, IAM roles are commonly used in scenarios like EC2 instances accessing other AWS services, allowing AWS Lambda functions to access specific resources, or granting cross-account access.

### STEPS

- Step 1: Create **provider.tf**, **iam_role_1.tf**, **iam_role_2.tf**.
- Step 2: Run the below command
- Step 3: Go to the AWS console and verify the IAM Role is created or not

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.

### Best practices for creating IAM roles with Terraform

When creating IAM roles with Terraform, focus on minimizing permissions, isolating trust policies, and structuring configurations for clarity and reusability in AWS environments.

- **Separate role and permissions logic**: Define the `aws_iam_role` with a minimal ``assume_role_policy`, then attach permissions via `aws_iam_policy`and`aws_iam_role_policy_attachment```. This prevents tight coupling and improves auditability.
- **Use principals precisely**: Explicitly define trusted entities (e.g., EC2, Lambda) in the trust policy using correct service principals like `"Service"**: "lambda.amazonaws.com"`.
- **Avoid inline policies for shared logic**: Prefer `aws_iam_policy` resources to centralize reusable permissions across roles instead of duplicating inline blocks.
- **Parameterize with constraints**: To prevent misconfiguration, use variables with input validation (`validation` blocks) for ARNs, paths, or tags.
- **Modularize role patterns**: Wrap IAM configurations in Terraform modules for roles with consistent patterns (e.g., ECS task roles), enabling versioned reuse across environments.
- **Avoid wildcards in permissions**: Replace overly broad statements like `"Action": "*"` with specific API actions to tighten access control.
