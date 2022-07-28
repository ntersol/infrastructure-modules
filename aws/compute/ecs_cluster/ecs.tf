resource "aws_ecs_cluster" "lead_api_ecs_cluster" {
  name = "lead-api-ecs-cluster"

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = false
        cloud_watch_log_group_name     = "/ecs/leads-api-cluster"
        s3_bucket_encryption_enabled   = false
                }
    }
  }
}