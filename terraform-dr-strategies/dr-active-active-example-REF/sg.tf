# =============================================================================
# PRIMARY REGION - Security Groups
# =============================================================================

# Security Group - ALB (Primary)
resource "aws_security_group" "alb_primary" {
  provider    = aws.primary
  name        = "${var.project_name}-primary-alb-sg"
  description = "Security group for Primary ALB"
  vpc_id      = aws_vpc.primary.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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
    Name = "${var.project_name}-primary-alb-sg"
  }
}

# Security Group - EC2 (Primary)
resource "aws_security_group" "ec2_primary" {
  provider    = aws.primary
  name        = "${var.project_name}-primary-ec2-sg"
  description = "Security group for Primary EC2"
  vpc_id      = aws_vpc.primary.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_primary.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-primary-ec2-sg"
  }
}

# =============================================================================
# SECONDARY REGION - Security Groups
# =============================================================================

# Security Group - ALB (Secondary)
resource "aws_security_group" "alb_secondary" {
  provider    = aws.secondary
  name        = "${var.project_name}-secondary-alb-sg"
  description = "Security group for Secondary ALB"
  vpc_id      = aws_vpc.secondary.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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
    Name = "${var.project_name}-secondary-alb-sg"
  }
}

# Security Group - EC2 (Secondary)
resource "aws_security_group" "ec2_secondary" {
  provider    = aws.secondary
  name        = "${var.project_name}-secondary-ec2-sg"
  description = "Security group for Secondary EC2"
  vpc_id      = aws_vpc.secondary.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_secondary.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-secondary-ec2-sg"
  }
}
