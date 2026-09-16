output "eks_role" {
    value = aws_iam_role.cluster_role.arn
}
output "ec2_role" {
    value = aws_iam_role.node_role.arn
}
output "eks_admin" {
  value = aws_iam_role.eks_admin.arn
}
output "inst_profile"{
    value = aws_iam_instance_profile.inst_profile.name
}