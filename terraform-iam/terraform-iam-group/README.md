## Create AWS IAM Group with Terraform

In this repository I’ll show an example how to create an AWS IAM Group with Terraform.

### Key components of AWS IAM

- **IAM User**

  - An AWS IAM User represents a single person or entity within your organization who interacts with AWS resources.
  - IAM users are typically used to assign specific permissions and access credentials (like access keys) to individuals who need to work within an AWS account.
  - IAM users have their own unique set of permissions and can have their own password or access keys for programmatic access to AWS resources.

- **IAM Group**

  - An AWS IAM Group is a collection of IAM users. Groups make it easier to manage permissions for multiple users.
  - You can assign permissions to groups rather than individual users, simplifying the process of granting and revoking access for multiple users at once.
  - IAM groups don't have their own credentials. Users within a group inherit the permissions assigned to that group.

- **IAM Policy**

  - An AWS IAM Policy is a JSON document that defines permissions, such as what actions are allowed or denied on what resources.
  - Policies are attached to IAM users, groups, or roles to define what actions they can perform within AWS services.
  - Policies are highly customizable, and you can create your own policies or use AWS managed policies. They follow the principle of least privilege, meaning users and roles should have the minimum permissions necessary to perform their tasks.

### STEPS

- Step 1: Create **provider.tf**, **dev_group.tf**, **group_policy.tf**, **outputs.tf** and **group_example2.tf**.
- Step 2: Run the below command
- Step 3: Go to the AWS console and verify

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
