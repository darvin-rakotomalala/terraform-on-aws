resource "aws_efs_file_system" "example-efs" {
  creation_token   = "example-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "TestEFS"
  }
}

resource "aws_efs_mount_target" "example-efs-mt" {
  file_system_id  = aws_efs_file_system.example-efs.id
  subnet_id       = aws_subnet.subnet-efs.id
  security_groups = [aws_security_group.ingress-efs.id]
}
