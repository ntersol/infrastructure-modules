resource "kubernetes_service" "lb-webhook-service" {
  metadata {
    annotations      = {
    "meta.helm.sh/release-name"      = "aws-load-balancer-controller"
    "meta.helm.sh/release-namespace" = "kube-system"
    }
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
      "app.kubernetes.io/component"   = "webhook"
      "app.kubernetes.io/instance"    = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by"  = "Helm"
      "app.kubernetes.io/version"     = "v2.4.2"
      "helm.sh/chart"                 = "aws-load-balancer-controller-1.4.2"
      "prometheus.io/service-monitor" = "false"
    }
    name      = "aws-load-balancer-webhook-service"
    namespace = "kube-system"
  }
  spec {
    port {
      port       = 443
      target_port = 9443
    }
    selector = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
      "app.kubernetes.io/instance"  = "aws-load-balancer-controller"
    }
  }
}