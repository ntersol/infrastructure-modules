variable "cluster_name" {
    type = string
}

variable "cluster_id" {
    type = string
}

variable "subnets" {
    description = "To provide all subnets in a list (e.g., from a count resource), use this syntax: [for subnet in aws_subnet.private : subnet.id]"
    type        = list(string)
}

variable "security_groups" {
    type = list(string)
}

variable "target_groups" {
    type    = list(string)
    default = null
}

variable "container_count" {
    type    = number
    default = 2
}

variable "port" {
    type = number
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}