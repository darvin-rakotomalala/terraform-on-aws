resource "aws_kms_key" "clustername" {
  count       = length(var.clustername) //count will be number of keys
  description = var.clustername[count.index]
}

resource "aws_kms_alias" "clustername-alias" {
  count         = length(var.clustername) //count will be number of key aliases
  name          = "alias/${var.clustername[count.index]}-alias"
  target_key_id = aws_kms_key.clustername[count.index].key_id
}
