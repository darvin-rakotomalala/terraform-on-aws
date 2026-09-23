############################################
### Shared File Storage for Container Workloads
############################################
resource "aws_efs_access_point" "containers" {
  file_system_id = aws_efs_file_system.main.id
  root_directory {
    path = "/container-data"
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = "755"
    }
  }
}

############################################
### WordPress File Storage
############################################
resource "aws_efs_access_point" "wordpress" {
  file_system_id = aws_efs_file_system.main.id
  root_directory {
    path = "/wordpress"
    creation_info {
      owner_gid   = 33
      owner_uid   = 33
      permissions = "755"
    }
  }
}
