resource "aws_ecs_service" "service" {
  name                   = "${var.name}-service"
  cluster                = var.cluster_id
  task_definition        = aws_ecs_task_definition.task.arn
  desired_count          = 2
  launch_type            = "FARGATE"
  enable_execute_command = true
  
  for i in len(var.target_groups) :
    load_balancer {
      target_group_arn = var.target_groups[i]
      container_name   = var.name
      container_port   = var.ports[i]
    }

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }
}