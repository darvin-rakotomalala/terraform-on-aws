## Create an AWS EC2 Auto-Scaling Group for High Availability using Terraform

In this project, we will use Terraform to create an autoscaling group that can automatically scale our EC2 instances up or down based on demand. This will ensure that we always have the right number of instances running to meet our application’s needs.

### Architecting our application


### Tasks

- Launch an Auto Scaling group that spans 2 subnets in your Custom VPC.
- Create a security group that allows traffic from the internet and associate it with the Auto Scaling group instances.
- Include a script in your user data to launch an Apache webserver. The Auto Scaling group should have a min of 2 and max of 5.
- To verify everything is working check the public ip addresses of the two instances. Manually terminate one of the instances to verify that another one spins up to meet the minimum requirement of 2 instances.
- Add an ALB in front of the Auto Scaling group.
- Create a security group for the ALB that allows traffic from the internet and associate it with the ALB.
- Modify the Auto Scaling group security group to allow only traffic from the ALB.
- Output the public dns name of the ALB and verify you are able to reach your webservers from your browser.
- The custom vpc should have 2 public subnets, 2 private subnets, a public route table and private route table, a NAT Gateway in the public subnet, and an Internet Gateway so there is outbound internet traffic.
- Launch your ALB in the public subnets.
- Launch your Auto Scaling group in your private subnets
- Output your public DNS of your ALB and then verify you can reach your Webserver via the URL.

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy)** – Removes resources when no longer needed.
