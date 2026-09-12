data "aws_subnet" "default_public1"{
    filter {
        name = "tag:Name"
        values = ["deafult_public1"]
    }
}
data "aws_subnet" "default_public2" {
    filter {
        name = "tag:Name"
        values = ["default_public2"]
    }
}

resource "aws_efs_file_system" "efs1" {
    #encrypted = true
    #creation_token = "dev-app-efs" #To avoid duplication creation not needed anymore
    tags = {
        Name = "dev_app_efs"
    }
}

resource "aws_efs_mount_target" "mount_targ" {
    for_each = {
      az1 = data.aws_subnet.default_public1.id
      az2 = data.aws_subnet.default_public2.id
    }
    file_system_id = aws_efs_file_system.efs1.id
    subnet_id =  each.value
    security_groups = [ aws_security_group.efs.id ]
    
    depends_on = [ aws_efs_file_system.efs1 ]
}