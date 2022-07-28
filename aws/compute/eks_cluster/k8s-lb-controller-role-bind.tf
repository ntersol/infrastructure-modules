resource "kubernetes_cluster_role_binding" "lb-controller-rbinding" {
  depends_on = [aws_eks_cluster.lead_api_cluster]
  metadata {
    annotations      = {
      "meta.helm.sh/release-name"      = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace" = "kube-system"
    }
    labels = {
      "app.kubernetes.io/instance"   = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/version"    = "v2.4.2"
      "helm.sh/chart"                = "aws-load-balancer-controller-1.4.2"
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
    }
    name = "aws-load-balancer-controller-rolebinding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "aws-load-balancer-controller-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
}