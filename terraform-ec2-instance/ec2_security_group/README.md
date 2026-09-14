## Managing AWS Security Groups Through Terraform

**What makes up a security group?**

A security group is composed of rules. A rule consists of the following components:

- Protocol
- Port range
- Source
- Destination

A security group has separate rule sets for incoming and outgoing traffic:

- An **inbound rule** consists of a protocol, a port(s), and a source.
- An **outbound rule** consists of a protocol, a port(s), and a destination.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed

### STEPS

- Step 1: Create **provider.tf**, **ec2.tf**, and **sg.tf**. Run the above command.
- Step 2: Create **sg_standalone_rules.tf** to convert inline security group rules to standalone rules.
- Step 3: Create **existing_sg.tf** to test existing security groups.
