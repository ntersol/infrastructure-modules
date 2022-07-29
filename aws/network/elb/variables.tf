variable "name" {
    type = string
}

variable "public_subnets" {
    type = list(string)
}

variable "security_groups" {
    type = list(string)
}

variable "vpc" {
    type = string
}

variable "port" {
    default = 80
    type    = number
}

variable "health_check_path" {
    default = "/"
    type    = string
}

variable "certificate_arn" {
    type = string
}