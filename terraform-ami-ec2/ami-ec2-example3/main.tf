# Step 1: Read the existing EC2 instance
data "aws_instance" "existing_ec2" {
  # instance_id = "i-0a8b1d8ac9f3b9201"
  filter {
    name   = "tag:Name"
    values = ["devops-ec2"]
  }
}

# Step 2: Create AMI from existing EC2
resource "aws_ami_from_instance" "devops_ami" {
  name               = "devops-ec2-ami"
  source_instance_id = data.aws_instance.existing_ec2.id
}

# Step 3: Launch a new EC2 from the AMI
resource "aws_instance" "devops_ec2_new" {
  ami           = aws_ami_from_instance.devops_ami.id
  instance_type = "t3.micro"

  tags = {
    Name = "devops-ec2-new"
  }
}
