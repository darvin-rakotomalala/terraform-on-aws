/*
    This is where our Dockerized app actually runs on Fargate inside private subnets, 
    connected securely to the ALB.
*/
# Create secure parameter in SSM Parameter Store
resource "aws_ssm_parameter" "environment_name_one" {
  name        = "/${var.app_name}/${var.environment_name_one_key}"
  type        = "SecureString"
  value       = var.environment_name_one_value
  overwrite   = false
  description = "Secure parameter for ${var.environment_name_one_key} in ${var.app_name} application"
  lifecycle {
    prevent_destroy = false
  }
}

# Create ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster"
}

# Create task definition
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.app_name}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode(
    [
      {
        name   = "${var.app_name}-container"
        image  = "${aws_ecr_repository.app_repo.repository_url}:latest"
        cpu    = var.fargate_cpu
        memory = var.fargate_memory
        portMappings = [
          {
            containerPort = var.app_port
            hostPort      = var.app_port
            protocol      = "tcp"
          }
        ]
        environment = [
          {
            name  = "PORT"
            value = tostring(var.app_port)
          }
        ]
        secrets = [
          {
            name      = var.environment_name_one_key
            valueFrom = aws_ssm_parameter.environment_name_one.arn
          }
        ]
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            "awslogs-group"         = "/ecs/${var.app_name}-log"
            "awslogs-region"        = var.aws_region
            "awslogs-stream-prefix" = "ecs"
          }
        }
      }
    ]
  )
}

# Create ECS service
resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  # Load Balancer
  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "${var.app_name}-container"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs-task-execution-role-policy]
}
/*
    Notes:
    - SSM Parameter Store: Stores sensitive values securely and injects them into ECS tasks.
    - ECS Cluster: Logical grouping for ECS services and tasks.
    - Task Definition: Blueprint for how containers run (CPU, memory, image, ports, env vars, logs).
    - ECS Service: Runs tasks on Fargate, integrates with ALB for traffic routing, and manages scaling.
    - Private Subnets: Tasks run securely without public IPs; only ALB can reach them.

    At this stage, our application is ready to run in a secure, scalable Fargate environment behind an ALB.
*/