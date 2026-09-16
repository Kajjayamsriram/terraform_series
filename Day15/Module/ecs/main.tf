resource "aws_ecs_cluster" "ecs_cluster" {
    name = "${var.proj}-${var.env}"
    setting {
      name = "containerInsights"
      value = "enabled"
    }
    tags = var.tags
}

resource "aws_ecs_task_definition" "ecs_task" {
  family = "${var.proj}-${var.env}"
  requires_compatibilities = [ var.compatibility ]
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = var.ecs_role
  task_role_arn = var.ecs_role

  container_definitions = var.cont_def
}

resource "aws_ecs_service" "nginx" {
    name = "${var.proj}-${var.env}"
    cluster = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.ecs_task.arn

    launch_type = var.launch_type
    desired_count = var.desired_count
    network_configuration {
        subnets = var.subnets
        security_groups = [
            var.sg
        ]
        assign_public_ip = false
    }
    load_balancer {
      target_group_arn = var.lb_tg
      container_name = var.cont_name
      container_port = var.cont_port
    }

    deployment_configuration {
        strategy = "ROLLING"
    }

    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent = 200

    #debug
    enable_execute_command = true

}
