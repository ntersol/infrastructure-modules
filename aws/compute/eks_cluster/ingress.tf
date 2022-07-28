resource "kubernetes_ingress_v1" "ingress" {
  depends_on = [aws_eks_cluster.cluster]
  metadata {
    name = "${var.cluster_name}-ingress"
  }

  spec {
    ingress_class_name = "alb"
    rule {
      http {
        path {
          backend {
            service {
              name = "${var.cluster_name}-service"
              port {
                number = 80
              }
            }
          }

          path = "/*"
        }
      }
    }
  }
}