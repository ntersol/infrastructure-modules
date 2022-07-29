resource "kubernetes_ingress_class" "load_balancer_controller" {
  depends_on = [aws_eks_cluster.cluster]
  metadata {
    name = "alb"
    labels {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
  }

  spec {
    controller = "ingress.k8s.aws/alb"
    parameters {
      api_group = "elbv2.k8s.aws"
      kind      = "IngressClassParams"
      name      = "alb"
    }
  }
}