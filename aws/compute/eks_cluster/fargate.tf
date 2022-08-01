resource "aws_eks_fargate_profile" "app_fargate" {
  depends_on             = [aws_eks_cluster.cluster]
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "app_fargate_profile"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = [for subnet in var.subnets : subnet]

  selector {
    namespace = "default"
    labels = {
      app = var.name
    }
  }
}

resource "aws_eks_fargate_profile" "load_balancer_controller_fargate" {
  depends_on             = [aws_eks_cluster.cluster]
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "load_balancer_controller_fargate_profile"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = [for subnet in var.subnets : subnet]

  selector {
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
  }
}

resource "aws_eks_fargate_profile" "coredns_fargate" {
  depends_on             = [aws_eks_cluster.cluster]
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "coredns_fargate_profile"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = [for subnet in var.subnets : subnet]
  
  selector {
    namespace = "kube-system"
    labels = {
      "k8s-app" = "kube-dns"
    }
  }
}