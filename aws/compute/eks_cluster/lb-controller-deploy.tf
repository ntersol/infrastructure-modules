resource "kubernetes_deployment" "lb_controller_deploy" {
  depends_on = [aws_eks_cluster.cluster]
  metadata {
    annotations      = {
      "meta.helm.sh/release-name"         = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace"    = "kube-system"
      "alb.ingress.kubernetes.io/subnets" = "subnet-06ed5c843245e357f,subnet-00add2426c45800ee"
    }
    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/instance"   = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/version"    = "v2.4.2"
      "helm.sh/chart"                = "aws-load-balancer-controller-1.4.2"
    }
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "aws-load-balancer-controller"
        "app.kubernetes.io/instance" = "aws-load-balancer-controller"
      }
    }
    template {
      metadata {
        annotations = {
          "prometheus.io/port"   = "8080"
          "prometheus.io/scrape" = "true"
        }
        labels = {
          "app.kubernetes.io/name" = "aws-load-balancer-controller"
          "app.kubernetes.io/instance" = "aws-load-balancer-controller"
        }
      }
      spec {
        container {
          args  = ["--cluster-name=${var.cluster_name}-cluster","--ingress-class=alb","--aws-vpc-id=${aws_vpc.main.id}","--aws-region=${data.aws_region.current.name}"]
          image = "602401143452.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/amazon/aws-load-balancer-controller:v2.4.2"
          name  = "controller"
          liveness_probe {
            failure_threshold = 2
            http_get {
              path = "/healthz"
              port = 61779
              scheme = "HTTP"
            }
            initial_delay_seconds = 30
            timeout_seconds       = 10
          }

          port {
            container_port = 9443
            name          = "webhook-server"
            protocol      = "TCP"
          }
          
          resources {
            limits = {
              cpu    = "200m"
              memory = "500Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "200Mi"
            }
          }
          
          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem   = true
            run_as_non_root             = true
          }
          
          volume_mount {
            mount_path = "/tmp/k8s-webhook-server/serving-certs"
            name       = "cert"
            read_only  = true
          }
        }
        
        security_context {
          fs_group = 1337
        }
        
        priority_class_name  = "system-cluster-critical"
        service_account_name = "aws-load-balancer-controller"
        
        volume {
          name = "cert"
          secret {
            default_mode = "0420"
            secret_name  = "aws-load-balancer-tls"
          }
        }
      }
    }
  }
}