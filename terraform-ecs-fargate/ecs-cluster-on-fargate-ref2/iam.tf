/*
    Our setup enforces the principle of least privilege, ensuring each role 
    has only the permissions required.
*/

# Data source to fetch the current AWS account ID
data "aws_caller_identity" "current" {}

# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_execution_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole",
        Sid    = "ECSAssumeRole"
      }
    ]
  })
}

# ECS task role
resource "aws_iam_role" "ecs_task_role" {
  name = var.ecs_task_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole",
        Sid    = "ECSAssumeRole"
      }
    ]
  })
}

# Attach ECS task execution role policy
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Attach AmazonEC2ContainerRegistryReadOnly policy to ECS task execution role
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-ecr-access" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Create policy for ECS task to read variable from SSM parameter store
resource "aws_iam_policy" "ssm_policy" {
  name = "${var.app_name}-ssm-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ],
        Resource = [
          "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${var.app_name}/${var.environment_name_one_key}"
        ]
      }
    ]
  })
}

# Attach the SSM policy to the ECS task role
resource "aws_iam_role_policy_attachment" "ecs-task-role-ssm-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

# Data source to create a policy statement for ECS auto scale rule
# This role will allow ECS to manage auto scaling for the service
data "aws_iam_policy_document" "ecs_auto_scale_role" {
  version = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

# ECS auto scale role
resource "aws_iam_role" "ecs_auto_scale_role" {
  name               = var.ecs_auto_scale_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_auto_scale_role.json
}
