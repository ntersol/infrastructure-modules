variable "cluster_name" {
    type = string
}

variable "subnets" {
    description = "To provide all subnets in a list (e.g., from a count resource), use this syntax: [for subnet in aws_subnet.private : subnet.id]"
    type        = list(string)
}

variable "selector_label" {
  default = var.cluster_name
  type    = string
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}