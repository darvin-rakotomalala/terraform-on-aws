# Create an ECR repository
resource "aws_ecr_repository" "my_ecr_repo" {
  name                 = "my-app-repo" # Replace with your desired repository name
  image_tag_mutability = "MUTABLE"     # Or "IMMUTABLE" for preventing tag overwrites

  image_scanning_configuration {
    scan_on_push = true # Enable image scanning on push
  }

  tags = {
    Environment = "Development"
    Project     = "MyApplication"
  }
}

# Setting up AWS ECR lifecycle policies
resource "aws_ecr_lifecycle_policy" "my_policy" {
  repository = aws_ecr_repository.my_ecr_repo.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only 10 images"
        selection = {
          countType     = "imageCountMoreThan"
          countNumber   = 10
          tagStatus     = "tagged"
          tagPrefixList = ["prod-"]
        }
        action = {
          type = "expire"
        }
      },
      {
        "rulePriority" : 2,
        "description" : "Expire untagged images after 7 days",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 7
        },
        "action" : {
          "type" : "expire"
        }
      },
      {
        "rulePriority" : 3,
        "description" : "Expire images with 'dev-' prefix after 30 days",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPrefixList" : ["dev-"], // This is where tag_prefix_list is used correctly
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 30
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}

# Import existing ECR repository into Terraform
/*resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-node-app" # your-existing-ecr-repository-name
  import {
    to = aws_ecr_repository.my_ecr_repo
    id = "my-node-app" # your-existing-ecr-repository-name
  }
}*/
# $ terraform import aws_ecr_repository.my_ecr_repo your-existing-ecr-repository-name
