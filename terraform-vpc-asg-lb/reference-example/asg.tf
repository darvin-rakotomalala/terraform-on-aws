# AutoScalingGroup 
/*if the number of requests to the target groups increases, the Auto Scaling group will automatically scale the number 
of instances in the group up to handle the increased load. If the number of requests to the target groups decreases, 
the Auto Scaling group will automatically scale the number of instances in the group down to save costs.*/
resource "aws_autoscaling_group" "auto_scaling_group" {
  name             = "my-asg"
  desired_capacity = 2
  max_size         = 5
  min_size         = 2
  vpc_zone_identifier = flatten([
    aws_subnet.private_subnet.*.id,
  ])
  target_group_arns = [
    aws_lb_target_group.target_group.arn,
  ]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

# Launch Template and ASG Resources
resource "aws_launch_template" "launch_template" {
  name          = "${var.environment}-lt"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.aws_key_pair
  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.asg_security_group.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.environment}-asg-ec2"
    }
  }
  user_data = base64encode("${var.ec2_user_data}")
}
