resource "aws_autoscaling_group" "asg" {
    name = var.asg_name
    launch_template {
      id = var.lt
      version = "$Latest"
    }
    vpc_zone_identifier = var.subnets
    target_group_arns = var.tg
    min_size = var.min #2
    max_size = var.max #4
    desired_capacity = var.desired #2

    instance_maintenance_policy {
    min_healthy_percentage = 50
    max_healthy_percentage = 150
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
    autoscaling_group_name = aws_autoscaling_group.asg.name
    name = var.policy_name
    policy_type = var.policy_type
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
    target_value = var.target_value #60
    disable_scale_in = false
    }
    estimated_instance_warmup = 300
}

resource "aws_autoscaling_notification" "asg_notify" {
    topic_arn = var.sns
    group_names = [ aws_autoscaling_group.asg.name ]
    notifications = [ "autoscaling:EC2_INSTANCE_LAUNCH", "autoscaling:EC2_INSTANCE_TERMINATE", ]
}

data "aws_instances" "asg_instances" {
    instance_tags = {
      "aws:autoscaling:groupName" = aws_autoscaling_group.asg.name
    }
    instance_state_names = ["running", "pending"]
}