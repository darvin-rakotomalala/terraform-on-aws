## Setting up AWS Cognito with Terraform

Amazon Cognito provides authentication, authorization, and user management for web and mobile apps. Cognito is the tool
provided by AWS to handle (guess what) users. It is one of the easiest and fastest ways to implement sign-up, logins and
access control of your applications. This guide shows how to set up a basic Cognito using Terraform.

**AWS CLI Command to generate token :**

```
aws cognito-idp admin-initiate-auth  --region <REGION> --user-pool-id <USER_POOL_ID>  --client-id <CLIENT_ID> --auth-flow ADMIN_NO_SRP_AUTH --auth-parameters USERNAME=<USERNAME>,PASSWORD=<PASSWORD>
```

**Get token using ```client_id``` and ```client_secret``` from Cognito Auth Endpoint on postman:**

```
Authorization 
- Auth Type = OAuth 2.0
- Add auth data to = Request Headers
- Token = Available Tokens
- Header Prefix = Bearer
- Token type = TF_Token
- Grant type = Client Credentials
- Access Token URL = 
- Client ID = 
- Client Secret = 
- Scope = myapi/all
- Client Authentification = Send as Basic Auth header
```

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
