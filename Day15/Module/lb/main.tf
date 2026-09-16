resource "aws_lb" "lb" {
    name = "${var.project}-${var.env}"
    internal = var.internal
    load_balancer_type = var.load_balancer_type
    subnets= var.subnets
    security_groups = var.sg
}

resource "aws_lb_target_group" "lb_tg" {
  name  = "${var.project}-${var.env}"
  target_type = "ip"
  protocol = "HTTP"
  port =80
  vpc_id = var.vpc_id
  health_check {
    protocol = "HTTP"
    port = 80
    path = "/"
  }
}

resource "aws_lb_listener" "lb_listen" {
  load_balancer_arn = aws_lb.lb.arn
  protocol = "HTTP"
  port = 80
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}