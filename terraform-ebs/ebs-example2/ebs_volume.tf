resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_vol.id
  instance_id = aws_instance.server.id
}

resource "aws_ebs_volume" "ebs_vol" {
  availability_zone = var.availability_zone
  size              = 30
  type              = "gp3"
  # encrypted         = true
  tags = {
    Name = "my-VolumeData"
  }
}

resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = aws_ebs_volume.ebs_vol.id

  tags = {
    Name = "my-VolumeData_snap"
  }
}
