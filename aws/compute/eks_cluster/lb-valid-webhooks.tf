resource "kubernetes_validating_webhook_configuration_v1" "lb-webhook" {
  depends_on = [aws_eks_cluster.cluster]

  metadata {
    annotations = {
      "cert-manager.io/inject-ca-from" = "kube-system/aws-load-balancer-serving-cert"
      "meta.helm.sh/release-name"      = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace" = "kube-system"
    }
    labels = {
      "app.kubernetes.io/instance"   = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/version"    = "v2.4.2"
      "helm.sh/chart"                = "aws-load-balancer-controller-1.4.2"
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
    }
    name = "aws-load-balancer-webhook"
  }
  
  webhook {
    failure_policy            = "Fail"
    name                      = "vtargetgroupbinding.elbv2.k8s.aws"
    side_effects              = "None"
    admission_review_versions = ["v1beta1"]
    client_config {
      service {
        name      = "aws-load-balancer-webhook-service"
        namespace = "kube-system"
        path      = "/validate-elbv2-k8s-aws-v1beta1-targetgroupbinding"
      }
    }
    rule {
      api_groups   = ["elbv2.k8s.aws"]
      api_versions = ["v1beta1"]
      operations   = ["CREATE","UPDATE"]
      resources    = ["targetgroupbindings"]
    }
  }
  webhook {
    failure_policy            = "Fail"
    name                      = "vingress.elbv2.k8s.aws"
    side_effects              = "None"
    admission_review_versions = ["v1beta1"]
    match_policy              = "Equivalent"

    client_config {
      service {
        name      = "aws-load-balancer-webhook-service"
        namespace = "kube-system"
        path      = "/validate-networking-v1beta1-ingress"
      }
    }
    rule {
      api_groups   = ["networking.k8s.io"]
      api_versions = ["v1beta1"]
      operations   = ["CREATE","UPDATE"]
      resources    = ["ingresses"]
    }
  }
}