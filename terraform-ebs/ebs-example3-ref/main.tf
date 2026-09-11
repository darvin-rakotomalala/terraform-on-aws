resource "aws_instance" "firefly_instance" {
  provider      = aws.primary
  ami           = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS
  instance_type = "t2.micro"
  tags = {
    Name = "my-EC2-Server"
  }
}

################################################
## Defining EBS volumes
################################################
resource "aws_ebs_volume" "firefly_volume" {
  provider          = aws.primary
  availability_zone = aws_instance.firefly_instance.availability_zone
  size              = 30
}

resource "aws_volume_attachment" "firefly_volume_attachment" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.firefly_instance.id
  volume_id   = aws_ebs_volume.firefly_volume.id
}

################################################
## Creating snapshots
################################################
resource "aws_ebs_snapshot" "firefly_snapshot" {
  provider  = aws.primary
  volume_id = aws_ebs_volume.firefly_volume.id
  tags = {
    Name = "firefly-snapshot"
  }
}

################################################
## Creating cross-region snapshots
################################################

resource "aws_ebs_snapshot_copy" "cross_region_snapshot" {
  provider           = aws.secondary
  source_snapshot_id = aws_ebs_snapshot.firefly_snapshot.id
  source_region      = "us-east-1"
  tags = {
    Name = "cross-region-snapshot"
  }
}

resource "aws_ebs_volume" "restored_volume" {
  availability_zone = aws_instance.firefly_instance.availability_zone
  snapshot_id       = aws_ebs_snapshot.firefly_snapshot.id
}

resource "aws_volume_attachment" "restored_attachment" {
  device_name = "/dev/sdi"
  instance_id = aws_instance.firefly_instance.id
  volume_id   = aws_ebs_volume.restored_volume.id
}
