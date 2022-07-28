resource "kubernetes_ingress_v1" "leads_ingress" {
  metadata {
    name = "leads-ingress"
  }

  spec {
    ingress_class_name = "alb"
    rule {
      http {
        path {
          backend {
            service {
              name = "leads-api-service"
              port {
                number = 5000
              }
            }
          }

          path = "/api/*"
        }

        path {
          backend {
            service {
              name = "leads-ui-service"
              port {
                number = 4200
              }
            }
          }

          path = "/ui/*"
        }
      }
    }
  }
}