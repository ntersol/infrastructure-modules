variable db_instance_pass {
  type        = string
}

variable "name" {
  type        = string
}

variable "subnets" {
  type        = list(string)
}

variable "eng_ver" {
  type    = string
  default = "15.00.4198.2.v1"
}

variable "inst_size" {
  type    = string
  default = "db.t3.small"
}