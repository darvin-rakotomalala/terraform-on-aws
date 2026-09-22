# Create a ECR repository for the application
resource "aws_ecr_repository" "app_repo" {
  name                 = "${var.app_name}-repo"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

# Create a lifecycle policy for the ECR repository
resource "aws_ecr_lifecycle_policy" "app_repo_policy" {
  repository = aws_ecr_repository.app_repo.name

  # Policy to keep the last 3 images and expire the rest
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 3 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 3
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

/*
    Notes:
    - ECR Repository: Stores Docker images securely within AWS.
    - Immutability: Prevents overwriting existing tags.
    - Image Scanning: Automatically scans pushed images for vulnerabilities.
    - Lifecycle Policy: Keeps the last 3 images to optimize storage costs.

*/
