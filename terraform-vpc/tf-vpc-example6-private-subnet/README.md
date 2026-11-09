## Configure AWS VPC using Terraform

In this repository, I’ll show an example how to configure an AWS VPC and Private subnet using Terraform.
If a public subnet needs access to the Internet, then it will go through Internet Gateway and for the private subnet, it will go through NAT Gateway.

### Some of Amazon VPC key concepts

- **Virtual Private Cloud (VPC)**: a virtual network that resides on an AWS account
- **Subnet**: Range of IP address in VPC
- **Route Table**: Set of rules that consist of routes that determine how traffic should be redirected
- **Internet Gateway**: Gateway that connects VPC and Internet
- **NAT Gateway**: NAT Gateway needs to interact with the public internet and needs public IP, then NAT Gateway will reside in a public subnet.
- **VPC Endpoint**: Endpoint that enabled VPC to privately connect with supported AWS services without the need of Internet Gateway, NAT Gateway/Instance, VPN, or AWS Direct Connect.
- **CIDR Block**: CIDR(Classless Inter-Domain Routing) is a methodology that is used to aggregate route or IP address allocation.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
