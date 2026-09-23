########################################
### Security Groups
########################################
resource "aws_security_group" "efs" {
  name        = "efs-mount-target"
  description = "Allow NFS traffic for EFS mount targets"
  vpc_id      = var.vpc_id

  ingress {
    description     = "NFS from application instances"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.application.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "efs-mount-target-sg"
  }
}

# Your application security group (simplified)
resource "aws_security_group" "application" {
  name        = "application-ssh-http"
  description = "Application instances allow ssh and http traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "application-sg"
  }
}

