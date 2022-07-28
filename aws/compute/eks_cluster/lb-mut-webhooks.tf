resource "kubernetes_mutating_webhook_configuration_v1" "lb_webhook" {
  depends_on = [aws_eks_cluster.cluster]
  metadata {
    annotations = {
      "cert-manager.io/inject-ca-from" = "kube-system/aws-load-balancer-serving-cert"
      "meta.helm.sh/release-name"      = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace" = "kube-system"
    }
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
      "app.kubernetes.io/instance"    = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by"  = "Helm"
      "app.kubernetes.io/version"     = "v2.4.2"
      "helm.sh/chart"                 = "aws-load-balancer-controller-1.4.2"
    }
    name = "aws-load-balancer-webhook"
  }

  webhook {
    admission_review_versions = ["v1beta1"]
    side_effects              = "None"
    failure_policy            = "Fail"
    name                      = "mpod.elbv2.k8s.aws"

    client_config {
      service {
        name      = "aws-load-balancer-webhook-service"
        namespace = "kube-system"
        path      = "/mutate-v1-pod"
      }
    }
    
    namespace_selector {
      match_expressions {
        key      = "elbv2.k8s.aws/pod-readiness-gate-inject"
        operator = "In"
        values   = ["enabled"]
      }
    }
    
    object_selector {
      match_expressions {
        key      = "app.kubernetes.io/name"
        operator = "NotIn"
        values   = ["aws-load-balancer-controller"]
      }
    }
    
    rule {
      api_groups   = [""]
      api_versions = ["v1"]
      operations   = ["CREATE"]
      resources    = ["pods"]
    }
  }

  webhook {
    admission_review_versions = ["v1beta1"]
    side_effects              = "None"
    failure_policy            = "Fail"
    name                      = "mtargetgroupbinding.elbv2.k8s.aws"

    client_config {
      service {
        name      = "aws-load-balancer-webhook-service"
        namespace = "kube-system"
        path      = "/mutate-elbv2-k8s-aws-v1beta1-targetgroupbinding"
      }
    }
 
    rule {
      api_groups   = ["elbv2.k8s.aws"]
      api_versions = ["v1beta1"]
      operations   = ["CREATE","UPDATE"]
      resources    = ["targetgroupbindings"]
    }
  }
}