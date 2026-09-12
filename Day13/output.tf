output "instances" {
    value = {
        for name, inst in aws_instance.inst:
        name => inst.id
    }
}
output "filesystem_id" {
    value = aws_efs_file_system.efs1.id
}
output "efs_mount_targets" {
    value = {
        for name, mt in aws_efs_mount_target.mount_targ :
        name => mt.id
    }
}