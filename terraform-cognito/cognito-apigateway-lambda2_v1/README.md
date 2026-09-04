## Set up API Gateway with AWS Cognito Authentication using OAuth 2.0 with Terraform

This guide shows how to secure API Gateway with AWS Cognito Authentication using Client Credentials grant type of OAuth
2.0 authorization and Custom Domains with Terraform.

**What is an AWS Cognito User Pool?**

AWS Cognito User Pool is a user directory service that enables authentication and authorization using industry-standard
protocols such as OAuth 2.0, OpenID Connect (OIDC), and SAML.

Using a Cognito User Pool for OAuth token authentication allows API Gateway to validate access tokens without the need
for a custom Lambda Authorizer, reducing complexity and improving performance.

**What is OAuth 2.0 and Its Grant Types?**

OAuth 2.0 is an authorization framework that allows applications to securely access user resources without exposing
credentials.

OAuth 2.0 Grant Types:

- **Authorization Code Grant**: Used for server-side applications where tokens are retrieved via a separate
  authorization server.
- **Implicit Grant**: Suitable for single-page applications (SPA) where tokens are obtained directly from the
  authorization server.
- **Client Credentials Grant**: Used for machine-to-machine authentication where no user interaction is required.
- **Resource Owner Password Grant**: Deprecated but allows users to provide credentials directly to the application.

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
