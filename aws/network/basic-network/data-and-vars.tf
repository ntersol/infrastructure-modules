data "aws_availability_zones" "available" {
  state = "available"
}

variable "count" {
  description = "Number of AZs to use, and therefore subnets to create of each type, etc."
  type        = number
}