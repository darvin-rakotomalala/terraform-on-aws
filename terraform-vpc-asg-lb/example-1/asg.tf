# Create ASG Launch Configuration
resource "aws_launch_template" "webteir_launch_config" {
  name_prefix            = "tf-webteir"
  image_id               = "ami-020cba7c55df1f615"
  instance_type          = var.instance_type
  key_name               = var.aws_key_pair
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = filebase64("${path.module}/install_script.sh")
  lifecycle {
    create_before_destroy = true
  }
}

# Create Autoscaling Group
resource "aws_autoscaling_group" "autoscaling_group_webteir" {
  name                      = "tf-asg-webteir"
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_size
  max_size                  = var.asg_max_size
  target_group_arns         = ["${aws_lb_target_group.CustomTG.arn}"]
  health_check_grace_period = 150
  health_check_type         = "ELB"
  vpc_zone_identifier       = [aws_subnet.PublicSubnet1.id, aws_subnet.PublicSubnet2.id]

  launch_template {
    id      = aws_launch_template.webteir_launch_config.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "tf-asg-webteir"
    propagate_at_launch = true
  }
}
