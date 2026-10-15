output "ecomm_instance_ip" {
  value = aws_instance.ecomm.public_ip
}

output "ecomm_instance_public_dns" {
  value = aws_instance.ecomm.public_dns
}

output "food_instance_ip" {
  value = aws_instance.food.public_ip
}

output "food_instance_public_dns" {
  value = aws_instance.food.public_dns
}

# DNS of LoadBalancer
output "lb_dns_name" {
  description = "DNS of Load balancer"
  value       = aws_lb.external-alb.dns_name
}
