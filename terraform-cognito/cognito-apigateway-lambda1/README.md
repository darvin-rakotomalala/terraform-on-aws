## Secure API Gateway using Cognito User Pool with Terraform

This guide shows how to secure API Gateway using Cognito User Pool with Terraform.

**AWS CLI Command to generate token :**

```
aws cognito-idp admin-initiate-auth  --region <REGION> --user-pool-id <USER_POOL_ID>  --client-id <CLIENT_ID> --auth-flow ADMIN_NO_SRP_AUTH --auth-parameters USERNAME=<USERNAME>,PASSWORD=<PASSWORD>
```

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
