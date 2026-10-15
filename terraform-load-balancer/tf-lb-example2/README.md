## Managing Application Load Balancer (ALB) with Terraform

In this repository, we will see how to manage ALB in AWS via Terraform. We integrate the ALB with EC2 instances, which are part of separate target groups.

### STEPS

- Configure the EC2 instances
  - Instance A – responds to root path
  - Instance B – responds to `/images/` path
  - Instance C – responds to `/register/` path
- Create an ALB Target Group

  - Target Group A – is a group of instances that serves all the incoming requests targeted towards the home page, as well as all those requests that are not served by other target groups.
  - Target Group B – is a group of instances that serves all the incoming requests made on the `/images `path.
  - Target Group C – is a group of instances that serves all the incoming requests made on the `/register` path.

- Add the ALB Target Group attachment

  - Instance A :: Target Group A
  - Instance B :: Target Group B
  - Instance C :: Target Group C

- Create an ALB Listener / Manage custom ALB Listener rules
  - Default Listener rules to Target Groups A
  - Rules to route the requests to Target Groups B and C
- Test the path-based routing on ALB

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
