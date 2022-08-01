output "pub_subnets" {
    value = [ for sub in aws_subnet.public : sub.id]
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "priv_subnets" {
    value = [ for sub in aws_subnet.private : sub.id]
}