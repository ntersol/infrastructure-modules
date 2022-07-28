resource "aws_ecs_task_definition" "task" {
  family = "${var.cluster_name}-task"
  requires_compatibilities = ["FARGATE"]  
  container_definitions = jsonencode([
    {
      name      = ${var.cluster_name}
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.cluster_name}:latest"
      portMappings = [
        {
          containerPort = "${var.api_port}"
          hostPort      = "${var.api_port}"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-create-group  = "true"
          awslogs-group         = "/ecs/${var.cluster_name}-cluster"
          awslogs-region        = "${data.aws_region.current.name}"
          awslogs-stream-prefix = "${var.cluster_name}"
        }
      }
    }
  ])

  memory             = 2048
  cpu                = 1024
  network_mode       = "awsvpc"
  execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}