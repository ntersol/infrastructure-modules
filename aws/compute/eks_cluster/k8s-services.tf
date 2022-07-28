resource "kubernetes_service" "leads-api-service" {
  depends_on = [aws_eks_cluster.lead_api_cluster]
  metadata {
    name = "leads-api-service"
  }
  wait_for_load_balancer = false    

  spec {
    selector = {
      app = var.selector_label
    }

    port {
      port        = 5000
      target_port = 5000
      node_port   = 30050
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "leads-ui-service" {
  
  metadata {
    name = "leads-ui-service"
  }
  wait_for_load_balancer = false    

  spec {
    selector = {
      app = var.selector_label
    }

    port {
      port        = 4200
      target_port = 4200
      node_port   = 30042
    }

    type = "NodePort"
  }
}

variable "selector_label" {
  default = "leads-api"
  type    = string
}