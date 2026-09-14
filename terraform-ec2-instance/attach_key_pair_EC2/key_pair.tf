resource "aws_key_pair" "my_key" {
  key_name = "tf-key-pair"
  # public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuGCM1JlXWk1S+Qlg/1kc936pY1DhnbNt3imV7c0FjA darvin@hp"
  public_key = file("${path.module}/id_rsa.pub")
}

output "keyname" {
  value = aws_key_pair.my_key.key_name
}
