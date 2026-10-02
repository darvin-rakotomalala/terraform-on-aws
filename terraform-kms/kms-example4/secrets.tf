resource "aws_secretsmanager_secret" "app-keystore" {
  depends_on = [aws_kms_alias.clustername-alias]
  count      = length(var.clustername) //count will be number of keys
  name       = "${var.clustername[count.index]}-concat-app-keystore"
  kms_key_id = "alias/${var.clustername[count.index]}-alias"
}
