resource "aws_ecs_cluster" "cluster" {
  name = "${var.name}-ecs-cluster"

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = false
        cloud_watch_log_group_name     = "/ecs/${var.name}-cluster"
        s3_bucket_encryption_enabled   = false
                }
    }
  }
}