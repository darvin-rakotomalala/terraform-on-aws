## Build AWS VPC Using Terraform

In this repository, we'll explore how to use Terraform to create a VPC on AWS, including the various components that make up a VPC and the steps required to implement them. Build VPC, subnet, and route table with NAT gateway and internet gateway.

### KEY COMPONENTS

This setup includes the following components within the VPC that we will set up using Terraform.

- **AWC VPC** – Base Virtual Private Cloud that creates in the AWS.
- **Subnets** – Includes private and public subnets within 2 availability zones. (Here I’ve used 2 availability zones, but feel free to add more AZs per your requirement.)
- **Internet Gateway** – will allow instances under the public subnet to access the public internet and users to access things on the public subnet via the internet.
- **NAT Gateway** – will allow instances under private subnet to access public internet when there is any requirement like download patches, os updates, etc. But a NAT gateway allows only one-way communication that will not open a private subnet to the public internet.
- **Security Groups** – Security groups will be used in allowing who can access what inside this architecture
- **Route tables** – used to build the routing for IGW and NAT gateway.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
