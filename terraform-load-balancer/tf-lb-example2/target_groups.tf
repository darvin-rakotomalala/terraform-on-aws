// Target groups
resource "aws_lb_target_group" "my_tg_a" { // Target Group A
  name     = "tf-tg-a"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group" "my_tg_b" { // Target Group B
  name     = "tf-tg-b"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

resource "aws_lb_target_group" "my_tg_c" { // Target Group C
  name     = "tf-tg-c"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

// Target group attachment
resource "aws_lb_target_group_attachment" "tg_attachment_a" {
  target_group_arn = aws_lb_target_group.my_tg_a.arn
  target_id        = aws_instance.instance_a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_b" {
  target_group_arn = aws_lb_target_group.my_tg_b.arn
  target_id        = aws_instance.instance_b.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_c" {
  target_group_arn = aws_lb_target_group.my_tg_c.arn
  target_id        = aws_instance.instance_c.id
  port             = 80
}
