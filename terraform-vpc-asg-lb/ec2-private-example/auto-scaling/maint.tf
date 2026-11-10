# Security group for ASG instances
resource "aws_security_group" "asg_SecurityGroup" {
  name        = "asg-instances"
  description = "SG for ASG instances"
  vpc_id      = var.vpc_id
  tags = {
    Name = "ASG-SecurityGroup"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }
}

# Launch configuration
resource "aws_launch_template" "lc" {
  name_prefix   = "terraform-lc"
  image_id      = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  key_name      = var.aws_key_pair
  vpc_security_group_ids = [aws_security_group.asg_SecurityGroup.id]
  # user_data              = filebase64("${path.module}/install_script.sh")

  lifecycle {
    create_before_destroy = true
  }
}

# Auto scaling group
resource "aws_autoscaling_group" "private_asg" {
  name = "terraform-asg"
  vpc_zone_identifier = var.priv_subnets

  min_size         = 1
  desired_capacity = 2
  max_size         = 4

  launch_template {
    id      = aws_launch_template.lc.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "project-asg-instance"
    propagate_at_launch = true
  }
}
