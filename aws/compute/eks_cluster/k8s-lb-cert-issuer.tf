resource "kubernetes_manifest" "lb_selfsign_issuer" {
  depends_on = [aws_eks_cluster.lead_api_cluster]
  manifest = yamldecode(<<EOT
apiVersion: cert-manager.io/v1alpha2
kind: Issuer
metadata:
  labels:
    app.kubernetes.io/name: aws-load-balancer-controller
  name: aws-load-balancer-selfsigned-issuer
  namespace: kube-system
spec:
  selfSigned: {}
EOT
)
}