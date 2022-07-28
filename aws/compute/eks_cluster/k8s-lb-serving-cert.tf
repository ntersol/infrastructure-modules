resource "kubernetes_manifest" "lb_serving_cert" {
  depends_on = [aws_eks_cluster.lead_api_cluster]
  manifest = yamldecode(<<EOT
apiVersion: cert-manager.io/v1alpha2
kind: Certificate
metadata:
  labels:
    app.kubernetes.io/name: aws-load-balancer-controller
  name: aws-load-balancer-serving-cert
  namespace: kube-system
spec:
  dnsNames:
  - aws-load-balancer-webhook-service.kube-system.svc
  - aws-load-balancer-webhook-service.kube-system.svc.cluster.local
  issuerRef:
    kind: Issuer
    name: aws-load-balancer-selfsigned-issuer
  secretName: aws-load-balancer-tls
EOT
  )
}