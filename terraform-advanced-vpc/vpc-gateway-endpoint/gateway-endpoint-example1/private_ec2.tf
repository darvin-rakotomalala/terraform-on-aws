# EC2 Instance in Private Subnet
resource "aws_instance" "private_ec2" {
  ami                  = "ami-020cba7c55df1f615"
  instance_type        = "t2.micro"
  key_name             = "my-key-pair"
  subnet_id            = aws_subnet.private_subnet.id
  security_groups      = [aws_security_group.private_sg.id]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  tags = {
    "Name" = "PRIVATE_EC2_HOST"
    "VPC"  = "AWS_NETWORKING_EXAM_IGW"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "PRIVATE_INSTNACE_INSTANCE_PROFILE"
  tags = {
    "Name" : "PRIVATE_INSTNACE_INSTANCE_PROFILE"
  }
  role = aws_iam_role.s3_iam_role.name
}

resource "aws_iam_role" "s3_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_doc.json
}

data "aws_iam_policy_document" "assume_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "role_policies" {
  role   = aws_iam_role.s3_iam_role.id
  policy = data.aws_iam_policy_document.iam_policy_doc.json
}

data "aws_iam_policy_document" "iam_policy_doc" {
  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}
