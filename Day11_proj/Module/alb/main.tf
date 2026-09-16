resource "aws_lb" "alb" {
    name = var.lb_name
    internal = var.internal
    load_balancer_type = "application"
    subnets = var.subnets
    security_groups = var.sg
}

resource "aws_lb_target_group" "tg" {
    name = "demo-tg"
    target_type = "instance"
    #or else instance/lambda
    protocol = "HTTP"
    port = 80
    vpc_id = var.vpc_id

    health_check {
      protocol = "HTTP"
      port = 80
      path = "/"
      healthy_threshold = 3
      unhealthy_threshold = 3
      timeout = 5
      interval = 30
    }
    stickiness {
    enabled         = true
    type            = "lb_cookie"
    cookie_duration = 3600
    }
}

resource "aws_lb_listener" "lb_lis" {
    load_balancer_arn = aws_lb.alb.arn
    protocol = "HTTP"
    port = 80
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}