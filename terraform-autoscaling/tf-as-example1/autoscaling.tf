resource "aws_launch_template" "ec2_template" {
  name_prefix                          = "tf-LT-"
  image_id                             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  key_name                             = "my-key-pair"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_sg.id]
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "tf-ec2-asg"
    }
  }
  user_data = filebase64("${path.module}/script_apache2.sh")
}

# Define Autoscaling Group
resource "aws_autoscaling_group" "my_asg" {
  name = "tf-asg-example"

  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = "$Latest"
  }

  min_size                  = 1
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = ["subnet-0c8df5b912dcf0400", "subnet-0e32beb8d1675f0d2"]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "tf-ASG"
    propagate_at_launch = true
  }
}
