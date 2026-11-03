locals {
  env          = "prod"
  service_name = "orders"
  main_queue   = "${local.service_name}-queue-${local.env}"
  dlq_queue    = "${local.service_name}-dlq-${local.env}"
}

/*
resource "aws_sqs_queue" "orders_queue" {
  name = local.main_queue
  # ...
}

resource "aws_sqs_queue" "orders_dlq" {
  name = local.dlq_queue
  # ...
}
*/
