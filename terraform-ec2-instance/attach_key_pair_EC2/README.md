## Create an SSH key in Amazon EC2 using Terraform

In this repository, we are going to create an ssh key on AWS and assign it to a newly created AWS instance.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed

### STEPS

- Step 1: Create an ssh keypair on our local system using the ssh-keygen command

```
$ ssh-keygen -t rsa
key file name : ./id_rsa
```

- Step 2: Copy **id_rsa** and **id_rsa.pub** files in or workspace.
- Step 3: Create **provider.tf**, **ec2.tf**, **key_pair.tf** and **sg.tf**
- Step 4: Run the above command
