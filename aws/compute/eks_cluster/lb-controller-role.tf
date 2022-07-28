resource "kubernetes_role" "lb_cont_leader_elect_role" {
  depends_on = [aws_eks_cluster.cluster]
  metadata {
    annotations      = {
      "meta.helm.sh/release-name"      = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace" = "kube-system"
    }
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
      "app.kubernetes.io/instance"   = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/version"    = "v2.4.2"
      "helm.sh/chart"                = "aws-load-balancer-controller-1.4.2"
      "name"                   = "aws-load-balancer-controller-leader-election-role"
    }
    namespace = "kube-system"
  }
  
  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["create"]
  }

  rule {
    api_groups     = [""]
    resource_names = ["aws-load-balancer-controller-leader"]
    resources      = ["configmaps"]
    verbs          = ["get","update","patch"]
  }
}