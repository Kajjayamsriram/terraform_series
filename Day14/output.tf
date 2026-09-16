output "subnets" {
    value = module.networking.subnets
}
output "eks_role" {
    value = module.iam.eks_role
}
output "ec2_role" {
    value = module.iam.ec2_role
}
output "cluster_name" {
  value = module.eks.cluster_name
}
output "cluster_endpoint"{
    value = module.eks.cluster_endpoint

}
output "update_kubeconfig"{
    value = module.eks.update_kubeconfig
}
output "sg" {
    value = module.sg.sg
}
output "ecr"{
    value = module.ecr.ecr_repo
}
# output "launch_template" {
#   value = module.lt.launch_template
# }
# output "launch_template_version" {
#   value = module.lt.launch_template_version
# }
# output "eks_admin"{
#     value = module.iam.eks_admin
# }
output "inst_profile" {
  value = module.iam.inst_profile
}