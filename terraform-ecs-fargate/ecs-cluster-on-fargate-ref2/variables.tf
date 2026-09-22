variable "app_name" {
  description = "Name of the application"
}

variable "aws_region" {
  description = "value for AWS region"
}

variable "ecs_task_role_name" {
  description = "Name of the ECS task role"
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
}

variable "ecs_auto_scale_role_name" {
  description = "Name of the ECS auto scaling role"
}

variable "az_count" {
  description = "Number of availability zones to use"
}

variable "app_port" {
  description = "Port on which the application will run"
}

variable "app_count" {
  description = "Number of docker containers to run"
}

variable "health_check_path" {
  description = "Path for the health check"
}

variable "fargate_cpu" {
  description = "CPU units for the Fargate task"
}

variable "fargate_memory" {
  description = "Memory in MiB for the Fargate task"
}

variable "environment_name_one_key" {
  description = "Key for the first environment variable"
}

variable "environment_name_one_value" {
  description = "Value for the first environment variable"
}
