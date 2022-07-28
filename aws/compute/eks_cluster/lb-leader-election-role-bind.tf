resource "kubernetes_role_binding" "lb_cont_elect-rbinding" {
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
    }
    name      = "aws-load-balancer-controller-leader-election-rolebinding"
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "aws-load-balancer-controller-leader-election-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
}