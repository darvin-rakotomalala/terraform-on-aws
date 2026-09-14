/*
    This example first creates a snapshot in the source region (e.g., us-east-1) 
    and then copies it to a target region (e.g., us-west-2). This ensures that your data 
    is protected even if a disaster occurs in your primary region.
*/
# Creating cross-region snapshots
/* TO UNCOMMENT
provider "aws" {
  region = "us-west-2"
}

resource "aws_ebs_snapshot_copy" "cross_region_snapshot" {
  source_snapshot_id = aws_ebs_snapshot.demo_snapshot.id
  source_region      = "us-east-1"
  tags = {
    Name = "tf-cross-region-snapshot"
  }
}

resource "aws_ebs_volume" "restored_volume" {
  availability_zone = aws_instance.web_server.availability_zone
  snapshot_id       = aws_ebs_snapshot.demo_snapshot.id
}

resource "aws_volume_attachment" "restored_attachment" {
  device_name = "/dev/sdi"
  instance_id = aws_instance.web_server.id
  volume_id   = aws_ebs_volume.restored_volume.id
}
*/
