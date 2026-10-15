output "instance_a_dns" {
  value = aws_instance.instance_a.public_dns
}

output "instance_b_dns" {
  value = aws_instance.instance_b.public_dns
}

output "instance_c_dns" {
  value = aws_instance.instance_c.public_dns
}

# DNS of LoadBalancer
output "lb_dns_name" {
  description = "DNS of Load balancer"
  value       = aws_lb.my_alb.dns_name
}
