output "launch_template" {
    value = aws_launch_template.eks.id
}
output "launch_template_version" {
  value = aws_launch_template.eks.latest_version
}