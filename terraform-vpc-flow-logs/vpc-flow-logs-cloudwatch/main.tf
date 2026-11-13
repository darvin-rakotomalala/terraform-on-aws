#################################################
## Basic VPC Flow Logs Setup
#################################################

# Reference the VPC
data "aws_vpc" "main" {
  tags = { Name = "main-vpc" }
}

# CloudWatch log group for flow logs
resource "aws_cloudwatch_log_group" "flow_logs" {
  name              = "/vpc/flow-logs/${data.aws_vpc.main.id}"
  retention_in_days = 7

  tags = { Name = "vpc-flow-logs" }
}

# IAM role for VPC Flow Logs to write to CloudWatch
resource "aws_iam_role" "flow_logs" {
  name = "vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })

  tags = { Name = "vpc-flow-logs-role" }
}

# IAM policy for writing to CloudWatch Logs
resource "aws_iam_role_policy" "flow_logs" {
  name = "vpc-flow-logs-policy"
  role = aws_iam_role.flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
        ]
        Resource = "*"
      }
    ]
  })
}

# VPC Flow Log resource
resource "aws_flow_log" "vpc" {
  vpc_id          = data.aws_vpc.main.id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_logs.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn

  tags = { Name = "vpc-flow-log" }
}

#################################################
## Custom Log Format
#################################################

# VPC Flow Log with custom format
resource "aws_flow_log" "vpc_custom" {
  vpc_id          = data.aws_vpc.main.id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_logs.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn

  # Custom log format with additional fields
  log_format = join(" ", [
    "$${version}",
    "$${account-id}",
    "$${interface-id}",
    "$${srcaddr}",
    "$${dstaddr}",
    "$${srcport}",
    "$${dstport}",
    "$${protocol}",
    "$${packets}",
    "$${bytes}",
    "$${start}",
    "$${end}",
    "$${action}",
    "$${log-status}",
    "$${vpc-id}",
    "$${subnet-id}",
    "$${az-id}",
    "$${sublocation-type}",
    "$${sublocation-id}",
    "$${pkt-srcaddr}",
    "$${pkt-dstaddr}",
    "$${region}",
    "$${pkt-src-aws-service}",
    "$${pkt-dst-aws-service}",
    "$${flow-direction}",
    "$${traffic-path}",
  ])

  # Maximum aggregation interval (1 minute for near-real-time)
  max_aggregation_interval = 60

  tags = { Name = "vpc-flow-log-custom" }
}

#################################################
## Subnet and ENI Level Flow Logs
#################################################

# Flow logs for a specific subnet
resource "aws_flow_log" "subnet" {
  subnet_id       = aws_subnet.private.id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_logs.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn

  max_aggregation_interval = 60

  tags = { Name = "subnet-flow-log" }
}

# Flow logs for a specific ENI
resource "aws_flow_log" "eni" {
  eni_id          = aws_instance.web.primary_network_interface_id
  traffic_type    = "REJECT" # Only capture rejected traffic
  iam_role_arn    = aws_iam_role.flow_logs.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn

  max_aggregation_interval = 60

  tags = { Name = "eni-flow-log" }
}

#################################################
## CloudWatch Metric Filters
#################################################

# Metric filter for rejected SSH traffic
resource "aws_cloudwatch_log_metric_filter" "rejected_ssh" {
  name           = "rejected-ssh-traffic"
  log_group_name = aws_cloudwatch_log_group.flow_logs.name

  pattern = "[version, account, eni, source, destination, srcport, dstport=22, protocol=6, packets, bytes, windowstart, windowend, action=REJECT, flowlogstatus]"

  metric_transformation {
    name          = "RejectedSSHTraffic"
    namespace     = "VPCFlowLogs"
    value         = "1"
    default_value = "0"
  }
}

# Metric filter for rejected traffic from specific source
resource "aws_cloudwatch_log_metric_filter" "rejected_traffic" {
  name           = "all-rejected-traffic"
  log_group_name = aws_cloudwatch_log_group.flow_logs.name

  pattern = "[version, account, eni, source, destination, srcport, dstport, protocol, packets, bytes, windowstart, windowend, action=REJECT, flowlogstatus]"

  metric_transformation {
    name          = "AllRejectedTraffic"
    namespace     = "VPCFlowLogs"
    value         = "$packets"
    default_value = "0"
  }
}

# Metric filter for large data transfers
resource "aws_cloudwatch_log_metric_filter" "large_transfers" {
  name           = "large-data-transfers"
  log_group_name = aws_cloudwatch_log_group.flow_logs.name

  pattern = "[version, account, eni, source, destination, srcport, dstport, protocol, packets, bytes > 1000000, windowstart, windowend, action=ACCEPT, flowlogstatus]"

  metric_transformation {
    name          = "LargeDataTransfers"
    namespace     = "VPCFlowLogs"
    value         = "$bytes"
    default_value = "0"
  }
}

#################################################
## CloudWatch Alarms
#################################################

# Alarm for excessive rejected SSH attempts
resource "aws_cloudwatch_metric_alarm" "ssh_brute_force" {
  alarm_name          = "ssh-brute-force-detected"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "RejectedSSHTraffic"
  namespace           = "VPCFlowLogs"
  period              = 300
  statistic           = "Sum"
  threshold           = 50
  alarm_description   = "Possible SSH brute force attack detected"

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

# Alarm for spike in rejected traffic
resource "aws_cloudwatch_metric_alarm" "rejected_spike" {
  alarm_name          = "rejected-traffic-spike"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "AllRejectedTraffic"
  namespace           = "VPCFlowLogs"
  period              = 300
  statistic           = "Sum"
  threshold           = 10000
  alarm_description   = "Unusual spike in rejected network traffic"

  alarm_actions = [aws_sns_topic.security_alerts.arn]
}

resource "aws_sns_topic" "security_alerts" {
  name = "vpc-security-alerts"
}

#################################################
## Multiple VPCs with Flow Logs
#################################################

variable "vpc_ids" {
  description = "List of VPC IDs to enable flow logs on"
  type        = list(string)
}

# Create flow logs for multiple VPCs
resource "aws_cloudwatch_log_group" "multi_flow_logs" {
  for_each = toset(var.vpc_ids)

  name              = "/vpc/flow-logs/${each.value}"
  retention_in_days = 7
}

resource "aws_flow_log" "multi_vpc" {
  for_each = toset(var.vpc_ids)

  vpc_id          = each.value
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_logs.arn
  log_destination = aws_cloudwatch_log_group.multi_flow_logs[each.key].arn

  max_aggregation_interval = 60

  tags = { Name = "flow-log-${each.value}" }
}
