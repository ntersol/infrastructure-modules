resource "kubernetes_manifest" "alb_ing_class_params" {
  depends_on = [aws_eks_cluster.cluster]
  manifest = yamldecode(<<EOF
apiVersion: elbv2.k8s.aws/v1beta1
kind: IngressClassParams
metadata:
  labels:
    app.kubernetes.io/name: aws-load-balancer-controller
  name: alb
EOF
  )
}