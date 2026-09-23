########################################
### EFS with ECS - CS Fargate supports EFS volumes natively.
########################################
resource "aws_ecs_task_definition" "app" {
  family                   = "my-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn

  volume {
    name = "shared-data"
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.main.id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.api.id
        iam             = "ENABLED"
      }
    }
  }

  container_definitions = jsonencode([
    {
      name  = "app"
      image = "my-app:latest"
      mountPoints = [
        {
          sourceVolume  = "shared-data"
          containerPath = "/data"
          readOnly      = false
        }
      ]
    }
  ])
}
