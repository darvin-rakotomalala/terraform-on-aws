## Bastion Hosts to restrict access to Private Hosts using Terraform

In this repository, I’ll show an example how to create AWS Networking with Terraform: Bastion Hosts to restrict access to Private Hosts.

A bastion host is a server whose purpose is to provide access to a private network from an external network, such as the Internet. Because of its exposure to potential attack, a bastion host must minimize the chances of penetration. For example, you can use a bastion host to mitigate the risk of allowing SSH connections from an external network to the Linux instances launched in a private subnet of your Amazon Virtual Private Cloud (VPC).

### Steps

- Step 1: Creating the VPC and Network Components - Create VPC with IGW, 1 Public and 1 private subnet with route table associations.
- Step 2: Deploying a Bastion Host in the Public Subnet and a Private Host in the Private Subnet
- Step 3: Implementing Access Restriction using Security Groups
- Steps to Run Terraform
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
