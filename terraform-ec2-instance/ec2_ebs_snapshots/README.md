## Implementing AWS EBS Volume Snapshots with Terraform

Terraform allows you to define and deploy your cloud resources in a consistent, repeatable manner, making it an excellent choice for managing disaster recovery.

**Key concepts of AWS EBS Volume Snapshots**

- What is Disaster Recovery?
- What are EBS Snapshots?
- Defining EBS volumes
- Creating cross-region snapshots
- Using AWS DLM for Scheduling Snapshots
- Restoring from EBS Snapshots

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed

### STEPS

- Step 1: Create **provider.tf**, **ec2.tf**, **sg.tf** **cross_region_snapshots.tf**, **dlm_scheduling.tf** and **restore_ebs_snapshots.tf**.
- Step 2: Run the above commands
