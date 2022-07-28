resource "kubernetes_cluster_role" "alb_ingress_controller" {
  depends_on = [aws_eks_cluster.lead_api_cluster]
  metadata {
    labels = {
      "app.kubernetes.io/name" = "alb-ingress-controller"
    }
    name = "alb-ingress-controller"
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["configmaps", "endpoints", "events", "ingresses", "ingresses/status", "services"]
    verbs      = ["create", "get", "list", "update", "watch", "patch"]
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["nodes", "pods", "secrets", "services", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "alb_ingress_controller_binding" {
  depends_on = [aws_eks_cluster.lead_api_cluster]
  metadata {
    labels = {
      "app.kubernetes.io/name" = "alb-ingress-controller"
    }
    name = "alb-ingress-controller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "alb-ingress-controller"
  }

  subject {
    namespace = "kube-system"
    kind      = "ServiceAccount"
    name      = "alb-ingress-controller"
  }
}