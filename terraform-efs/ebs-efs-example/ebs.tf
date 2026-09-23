resource "aws_ebs_volume" "data-vol" {
  availability_zone = "us-east-1"
  size              = 30
  tags = {
    Name = "my-data-volume"
  }
}

resource "aws_volume_attachment" "good-morning-vol" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.data-vol.id
  instance_id = aws_instance.webserver.id
}

resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = aws_ebs_volume.data-vol.id
  tags = {
    Name = "my-Snapshot"
  }
}
