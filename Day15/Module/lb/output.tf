output "lb_arn" {
  value = aws_lb.lb.arn
}
output "tg_arn" {
  value = aws_lb_target_group.lb_tg.arn
}