resource "aws_lb" "nlb" {
    name = "demonlb"
    internal = "false"
    load_balancer_type = "network"
    subnets = [aws_subnet.subnets["public1"].id, aws_subnet.subnets["public2"].id]
    #enable_deletion_protection = true
    security_groups = [aws_security_group.sg1.id]
    depends_on = [ aws_subnet.subnets, aws_security_group.sg1 ]
}

resource "aws_lb_listener" "lb_lisner" {
    load_balancer_arn = aws_lb.nlb.arn
    port = 80
    protocol = "TCP"
    default_action {
        type = "forward"
        forward {
          target_group {
            arn = aws_lb_target_group.tg1.arn
            weight = 100
          }
        }
    }
    depends_on = [ aws_lb.nlb ]
}

resource "aws_lb_target_group" "tg1" {
    target_type = "instance"
    name = "tg1"
    protocol = "TCP"
    port = 80
    vpc_id = aws_vpc.vpc1.id
    
    health_check {
     enabled = true 
     path = "/"
     timeout =3
     healthy_threshold = 2
     unhealthy_threshold = 2
     interval =30
    }
    depends_on = [ aws_lb.nlb ]
}
#note: here protocol = "TCP" as this is nlb, alb it will be HTTP