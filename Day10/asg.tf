resource "aws_autoscaling_group" "asg1" {
    name = "demoasg"
    launch_template {
        id = aws_launch_template.lt1.id
        version = "$Latest"
    }
    vpc_zone_identifier = [aws_subnet.subnets["private1"].id, aws_subnet.subnets["private2"].id]
    #load_balancers = [aws_lb.nlb.name]
    target_group_arns = [ aws_lb_target_group.tg1.arn ]
    desired_capacity = 2
    min_size =1
    max_size = 4
    depends_on = [ aws_launch_template.lt1, aws_subnet.subnets, aws_lb_target_group.tg1 ]
}
resource "aws_autoscaling_policy" "cpu_scale" {
    autoscaling_group_name = aws_autoscaling_group.asg1.name
    name = "asg_cpu_scaling"
    policy_type = "TargetTrackingScaling"
    estimated_instance_warmup = 300
    target_tracking_configuration {
        predefined_metric_specification {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
    target_value = 60
    disable_scale_in = false
    }
    depends_on = [ aws_autoscaling_group.asg1 ]
}

resource "aws_autoscaling_notification" "asg_notify" {
    group_names = [ aws_autoscaling_group.asg1.name ]
    topic_arn = aws_sns_topic.topic1.arn
    notifications = [ "autoscaling:EC2_INSTANCE_LAUNCH","autoscaling:EC2_INSTANCE_TERMINATE" ]
    depends_on = [ aws_autoscaling_group.asg1, aws_sns_topic.topic1 ]
}
#Note: For nlb, we have to pass the target_group_arn unlike lb for clbs