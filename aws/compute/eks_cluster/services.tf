resource "kubernetes_service" "service" {
  depends_on = [aws_eks_cluster.cluster]
  metadata {
    name = var.selector_label
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

resource "kubernetes_service" "service" {
  
  metadata {
    name = "${var.selector_label}-service"
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