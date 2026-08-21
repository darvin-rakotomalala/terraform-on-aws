# Data source to fetch information about the existing EC2 instance
data "aws_instance" "existing_ec2" {
  instance_id = "i-0a8b1d8ac9f3b9201" # Example: i-0a1b2c3d4e5f67890
}

# Resource to create the AMI from the existing instance
resource "aws_ami_from_instance" "example_ami" {
  name               = "example-ami-created-by-terraform"
  source_instance_id = data.aws_instance.existing_ec2.id
  description        = "An example AMI created from an existing EC2 instance using Terraform"
  # You can also add tags here if needed
  tags = {
    Name = "my-ami-created"
  }
}

# Optional: Launch a new EC2 instance from the newly created AMI
resource "aws_instance" "new_instance_from_ami" {
  ami           = aws_ami_from_instance.example_ami.id
  instance_type = "t3.micro" # Example instance type
  key_name      = "my-key-pair"
  # subnet_id              = "xxxxxxxxxxx" # Reference the subnet ID
  # vpc_security_group_ids = ["xxxxxxxxxxx"]
  tags = {
    Name = "new-instance-from-ami"
  }
}

# Output the new AMI ID
output "new_ami_id" {
  value = aws_ami_from_instance.example_ami.id
}

# Output the public IP of the instance to easily access it
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.new_instance_from_ami.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.new_instance_from_ami.id
}
