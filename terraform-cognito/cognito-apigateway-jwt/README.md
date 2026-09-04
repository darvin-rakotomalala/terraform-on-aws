## Setting up HTTP API Gateway with Cognito JWT and Terraform

This guide shows how to set up JWT Authorizer with Cognito User Pool using Terraform.

Amazon Cognito is a user authentication and authorization service provided by AWS. It offers:

- **Simple integration** for sign-up, sign-in, and access control in web and mobile apps.
- **Secure user account management**, supporting:
    - Social login providers like Google and Facebook.
    - Traditional email/password authentication.
    - Enterprise identity providers.

With a user created, you can log in (We can import this ```curl``` command into Postman):

```
curl --location --request POST 'https://cognito-idp.us-east-1.amazonaws.com' \
--header 'X-Amz-Target: AWSCognitoIdentityProviderService.InitiateAuth' \
--header 'Content-Type: application/x-amz-json-1.1' \
--data-raw '{
   "AuthParameters" : {
      "USERNAME" : "testUser",
      "PASSWORD" : "root@69127"
   },
   "AuthFlow" : "USER_PASSWORD_AUTH",
   "ClientId" : "h2lro23j7t078pfudjgtpiqb0"
}'
```

**Calling the API**
```curl --request GET 'https://dn6zzx5yo3.execute-api.us-east-1.amazonaws.com/dev/example' --header 'Authorizion: Bearer ${token}'```

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
