output "log_group_name" {
  value = module.cloudwatch.log_group_name
}
output "ecs_cluster_name"{
    value = module.ecs.ecs_cluster_name
}
output "ecs_service" {
    value = module.ecs.ecs_service
}
output "ecs_role" {
  value = module.iam.ecs_role
}
output "lb_arn" {
    value = module.lb.lb_arn
}
output "tg_arn" {
    value = module.lb.tg_arn
}
output "subnets" {
    value = module.network.subnets  
}
output "vpc_id" {
  value = module.network.vpc_id
}
output "sg"{
    value = module.sg.sg
}