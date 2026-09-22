# create ecs task definition, ecs service and ecs cluster
/*
    Below are the resources that ECS needs to be defined:
        - Cluster
        - Service
        - Task Definition
*/
resource "aws_ecs_cluster" "demo-ecs-cluster" {
  name = "ecs-cluster-for-demo"
}

resource "aws_ecs_task_definition" "demo-ecs-task-definition" {
  family                   = "ecs-task-definition-demo"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions    = <<EOF
    [
        {
            "name": "demo-container",
            "image": "123456789012.dkr.ecr.us-east-1.amazonaws.com/demo-repo:1.0",
            "memory": 1024,
            "cpu": 512,
            "essential": true,
            "entryPoint": ["/"],
            "portMappings": [
                {
                    "containerPort": 80,
                    "hostPort": 80
                }
            ]
        }
    ]
EOF
}

resource "aws_ecs_service" "demo-ecs-service-two" {
  name            = "demo-app"
  cluster         = aws_ecs_cluster.demo-ecs-cluster.id
  task_definition = aws_ecs_task_definition.demo-ecs-task-definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.public.id]
    security_groups  = [aws_security_group.fargate_sg.id]
    assign_public_ip = true
  }
  desired_count = 1
}
