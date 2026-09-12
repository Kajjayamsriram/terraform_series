output "inst_ids" {
    description = "Deployed Instance IDs"
    value = data.aws_instances.asg_instances.ids
}