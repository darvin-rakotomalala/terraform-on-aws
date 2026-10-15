/*
output "nlb_dns_name" {
  value = aws_lb.nlb.dns_name
}

output "nlb_arn" {
  value = aws_lb.nlb.arn
}

output "target_attachment_a" {
  value = aws_lb_target_group_attachment.tg_attachment_a.id
}

output "target_attachment_b" {
  value = aws_lb_target_group_attachment.tg_attachment_b.id
}

output "target_group_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.nlb-example-tg.arn
}

output "listener_arn" {
  description = "The ARN of the Listener"
  value       = aws_lb_listener.front_end.arn
}
*/