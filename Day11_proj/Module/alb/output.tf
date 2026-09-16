output "tg" {
    value = aws_lb_target_group.tg.arn
}
output "lb-dns" {
  value = aws_lb.alb.dns_name
}