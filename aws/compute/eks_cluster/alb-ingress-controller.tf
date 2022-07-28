resource "aws_iam_role" "alb_ingress_controller_role" {
  name = "alb_ingress_controller_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "alb_ingress_controller_policy_attachment" {
  policy_arn = aws_iam_policy.alb_ingress_controller_policy.arn
  role       = aws_iam_role.alb_ingress_controller_role.name
}

resource "aws_iam_policy" "alb_ingress_controller_policy" {
  name   = "ALBIngressControllerIAMPolicy"
  policy = file("alb-ingress-iam-policy.json")
}