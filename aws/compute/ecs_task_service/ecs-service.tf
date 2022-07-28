resource "aws_ecs_service" "lead_api_service" {
  name                   = "lead-api-service"
  cluster                = aws_ecs_cluster.lead_api_ecs_cluster.id
  task_definition        = aws_ecs_task_definition.leads_api_task.arn
  desired_count          = 2
  launch_type            = "FARGATE"
  enable_execute_command = true
  load_balancer {
    target_group_arn = aws_lb_target_group.lead_api_tg.arn
    container_name   = "lead-api"
    container_port   = var.api_port
  }

  # load_balancer {
  #   target_group_arn = aws_lb_target_group.lead_ui_tg.arn
  #   container_name   = "lead-api"
  #   container_port   = var.ui_port
  # }  

  network_configuration {
    subnets         = [for subnet in aws_subnet.private : subnet.id]
    security_groups = [aws_security_group.ecs_pub_sg.id]
  }
}