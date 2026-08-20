####################################################
# Create the IAM role for EC2 assumption
####################################################
resource "aws_iam_role" "ec2_s3_role" {
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        }
      },
    ]
  })
  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-iam-role"
  })
}

####################################################
# Create the IAM policy to allow all s3.* actions
####################################################
resource "aws_iam_policy" "ec2_s3_policy" {
  name = "ec2-iam-s3-policy"
  path = "/"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "s3:*"
          ],
          "Effect" : "Allow",
          "Resource" : "*"
        },
      ]
    }
  )
  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-s3-policy"
  })

}

####################################################
# Attach IAM policy to the role
####################################################
resource "aws_iam_policy_attachment" "ec2_s3_role_policy" {
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
  roles      = [aws_iam_role.ec2_s3_role.name]
  name       = "${var.naming_prefix}-ec2-s3-policy-att"
}

####################################################
# Create an EC2 instance profile with the role
####################################################
resource "aws_iam_instance_profile" "ec2_s3_instance_profile" {
  role = aws_iam_role.ec2_s3_role.name
  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-ec2-s3-instance-profile"
  })
}
