# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "fargate-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app_task" {
  family                   = "my-fargate-app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "my-nginx-app"
      image = "public.ecr.aws/nginx/nginx:trixie-perl" # Replace with your image
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/my-fargate-app"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name = "/ecs/my-fargate-app"
}

# ECS Service
# ECS service to manage and run your Fargate tasks in the public subnet
resource "aws_ecs_service" "app_service" {
  name            = "my-fargate-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public.id]
    security_groups  = [aws_security_group.fargate_sg.id]
    assign_public_ip = true
  }

  # Optional: For load balancing, uncomment and configure an ALB
  # load_balancer {
  #   target_group_arn = aws_lb_target_group.app_tg.arn
  #   container_name   = "my-app"
  #   container_port   = 80
  # }
}
