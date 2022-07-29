resource "kubernetes_cluster_role" "lb_controller_role" {
  depends_on = [aws_eks_cluster.cluster]
  metadata {
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
    name = "aws-load-balancer-controller-role"
  }

  rule {
    api_groups = [""]
    resources  = ["endpoints","namespaces","nodes","pods","secrets",]
    verbs      = ["get","list","watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods/status","services/status"]
    verbs      = ["patch","update"]
  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["patch","update","create"]
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get","list","patch","update","watch"]
  }

  rule {
    api_groups = ["elbv2.k8s.aws"]
    resources  = ["ingressclassparams"]
    verbs      = ["get","list","watch"]
  }

  rule {
    api_groups = ["elbv2.k8s.aws"]
    resources  = ["targetgroupbindings"]
    verbs      = ["create","delete","get","list","patch","update","watch"]
  }

  rule {
    api_groups = ["elbv2.k8s.aws"]
    resources  = [ "targetgroupbindings/status"]
    verbs      = ["patch","update"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses"]
    verbs      = ["get","list","patch","update","watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses/status"]
    verbs      = ["patch","update"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingressclasses"]
    verbs      = ["get","list","watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get","list","patch","update","watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses/status"]
    verbs      = ["patch","update"]
  }
}