resource "aws_flow_log" "main" {
  iam_role_arn         = aws_iam_role.flow_log_role.arn
  log_destination      = aws_cloudwatch_log_group.log_group.arn
  traffic_type         = "REJECT"
  vpc_id               = aws_vpc.main.id
  log_destination_type = "cloud-watch-logs"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "vpc-flow-log-group-69127"
  tags = {
    Environment = "demo"
  }
}

resource "aws_iam_role" "flow_log_role" {
  name               = "flow-log-role-69127"
  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "vpc-flow-logs.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
  EOF
}

resource "aws_iam_policy" "flow_log_policy" {
  name        = "flow-log-policy-69127"
  description = "Policy for VPC flow logs"
  policy      = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "VPCFlowLogsAccess",
          "Effect": "Allow",
          "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents"
          ],
          "Resource": "*"
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "flow_log_policy_attachment" {
  role       = aws_iam_role.flow_log_role.name
  policy_arn = aws_iam_policy.flow_log_policy.arn
}
