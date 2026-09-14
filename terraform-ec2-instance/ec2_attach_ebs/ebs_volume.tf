# Create an EBS volume . Then attach it to the EC2 instance
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_vol.id
  instance_id = aws_instance.web_server.id
}

resource "aws_ebs_volume" "ebs_vol" {
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  type              = "gp3" # Volume type
  encrypted         = true
  tags = {
    Name = "MyTerraformEBSVolume"
  }
}
