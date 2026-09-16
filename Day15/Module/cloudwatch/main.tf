resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.project}/${var.env}"
  retention_in_days = var.retention
  tags = var.tags
}