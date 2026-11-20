## Terraform Workspace – Manage Multiple Environments

Terraform worksapces is a very logical concept where you can have multiple states of your infrastructure configuration. To put this in simple words if you are running an infrastructure configuration in **development** environment then the same infrastructure can be run in the **production** environment.

Terraform workspace commands:

- **terraform workspace new dev** – Create a New Terraform Workspace for development.
- **terraform workspace new test** – Create a New Terraform Workspace for test.
- **terraform workspace list** – Listing All Terraform Workspaces.
- **terraform workspace show** – Showing the Active Terraform Workspace.
- **terraform workspace select dev** – Switching Between Terraform Workspaces.
- **terraform workspace delete** – Deletes an existing workspace.

### Practical

**Step 1: Using Workspace Name in Terraform Configuration**
While working with longer terraform infrastructure code it often needed to name or tag your resources based on the environment profile such as dev, test, stage, prod, etc.

Here is a simple example of provisioning a simple EC2 instance –

1. I have defined a terraform local `instance_name`
2. The terraform local have a name prefixed with the current workspace name .i.e. – `${terraform.workspace}-instance`
3. And the terraform local is used to tag the `aws_instance`

**Step 2: Let’s Deploy**

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan -var-file="dev.tfvars")** – Preview the changes Terraform will make to match your configuration for Dev Environment.
- **Plan (terraform plan -var-file="test.tfvars")** – Preview the changes Terraform will make to match your configuration for Test Environment.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -var-file="dev.tfvars")** – Removes resources for Dev Environment.
- **Destroy (terraform destroy -var-file="test.tfvars")** – Removes resources for Test Environment.

**Step 3: Verify on AWS console**
