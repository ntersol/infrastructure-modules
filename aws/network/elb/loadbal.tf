resource "aws_lb" "alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.pub_sg]
  subnets            = [for subnet in var.public_subnets : subnet.id]
}