resource "aws_eks_cluster" "cluster" {
  name     = "${var.name}-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
  
  tags = {
    "alpha.eksctl.io/cluster-oidc-enabled" = true
  }

  tags_all = {
    "alpha.eksctl.io/cluster-oidc-enabled" = true
  }

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${data.aws_region.current.name} --name ${this.name}"
  }
}