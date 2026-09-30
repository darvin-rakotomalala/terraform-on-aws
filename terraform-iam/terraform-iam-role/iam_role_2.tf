resource "aws_iam_role" "example_role" {
  name               = "examplerole"
  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
        },
            "Action": "sts:AssumeRole"
        }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "example_attachment" {
  role       = aws_iam_role.example_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "example_profile" {
  name = "example_profile"
  role = aws_iam_role.example_role.name
}

resource "aws_instance" "example_instance" {
  ami                         = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = "my-key-pair"
  iam_instance_profile        = aws_iam_instance_profile.example_profile.name
  associate_public_ip_address = true
  tags = {
    Name = "tf-exampleinstance"
  }
}

output "instance_ip" {
  value = aws_instance.example_instance.public_ip
}
