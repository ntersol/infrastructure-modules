resource "aws_ecs_service" "service" {
  name                   = "${var.name}-service"
  cluster                = var.cluster_id
  task_definition        = aws_ecs_task_definition.task.arn
  desired_count          = 2
  launch_type            = "FARGATE"
  enable_execute_command = true
  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.name
    container_port   = var.api_port
  } 

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }
}