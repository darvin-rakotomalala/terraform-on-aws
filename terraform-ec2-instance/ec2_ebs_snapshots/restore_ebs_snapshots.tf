/*
    First, you need to find the snapshot you want to restore from. This could be 
    a standard or archive snapshot, depending on your backup strategy.

    2. Create a New EBS Volume from Snapshot: Use the snapshot to create a new EBS volume. 
    This volume can be attached to an EC2 instance for further use. 
*/
/* TO UNCOMMENT
resource "aws_ebs_volume" "restored_volume" {
  snapshot_id       = "snap-xxxxxxxx"
  availability_zone = "us-east-1a"
  size              = 30
}
*/

/*
    3. Attach the New Volume to an EC2 Instance: After the volume is created, 
    you need to attach it to an EC2 instance.
*/
/* TO UNCOMMENT
resource "aws_volume_attachment" "volume_attachment" {
  device_name = "/dev/sdh"
  instance_id = "i-xxxxxxxx"
  volume_id   = aws_ebs_volume.restored_volume.id
}
*/
