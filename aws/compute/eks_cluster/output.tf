output "eks_ca" {
    value = aws_eks_cluster.cluster.certificate_authority
}