resource "aws_ecs_task_definition" "leads_api_task" {
  family = "leads-api-task"
  requires_compatibilities = ["FARGATE"]  
  container_definitions = jsonencode([
    {
      name      = "lead-api"
      image     = "016871311872.dkr.ecr.us-west-2.amazonaws.com/ntersol-leads-api:latest"
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
          awslogs-group         = "/ecs/leads-api-cluster"
          awslogs-region        = "us-west-2"
          awslogs-stream-prefix = "leads-api"
        }
      }
    }
  ])

  memory             = 2048
  cpu                = 1024
  network_mode       = "awsvpc"
  execution_role_arn = "arn:aws:iam::016871311872:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::016871311872:role/ecsTaskExecutionRole"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}