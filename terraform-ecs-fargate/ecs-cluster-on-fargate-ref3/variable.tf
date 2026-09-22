# ---- root/main
variable "container_name" {
  default = "my-container"
}

variable "container_image" {
  default = "583524027596.dkr.ecr.us-east-1.amazonaws.com/myapp-repo"
}

variable "cluster_name" {
  default = "my-cluster"
}

variable "service_name" {
  default = "my-service"
}

variable "capacity_provider" {
  default = "FARGATE"
}

variable "family" {
  default = "my-task"
}

variable "network_mode" {
  default = "awsvpc"
}

# variable "execution_role_arn" {
#   default = "arn:aws:iam::114148051138:role/ECS-ECR"
# }
# variable "task_role_arn" {
#   default = "arn:aws:iam::114148051138:role/ECS-ECR"
# }

variable "vpc_cidr" {
  default = "18.0.0.0/16"
}

variable "lb_name" {
  default = "fargate"
}

variable "lb_type" {
  default = "application"
}

variable "iam_policy_description" {
  default = "Policy for container to pull from ECR"
}

variable "policy_type" {
  default = "TargetTrackingScaling"
}

variable "asg_name" {
  default = "fargate"
}

variable "scalable_dimension" {
  default = "ecs:service:DesiredCount"
}

variable "service_namespace" {
  default = "ecs"
}

variable "iam_role_name" {
  default = "fargate_role"
}

variable "policy_name" {
  default = "Fargate-ECR-Policy"
}

variable "predefined_metric_type" {
  default = "ECSServiceAverageCPUUtilization"
}

variable "waf_name" {
  default = "waf-fargate"
}
