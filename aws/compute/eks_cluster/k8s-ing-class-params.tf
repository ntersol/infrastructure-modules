resource "kubernetes_manifest" "ing_class_params_crd" {
  depends_on = [aws_eks_cluster.lead_api_cluster]
  manifest = yamldecode(<<EOT
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.5.0
  creationTimestamp: null
  labels:
    app.kubernetes.io/name: aws-load-balancer-controller
  name: ingressclassparams.elbv2.k8s.aws
spec:
  group: elbv2.k8s.aws
  names:
    kind: IngressClassParams
    listKind: IngressClassParamsList
    plural: ingressclassparams
    singular: ingressclassparams
  scope: Cluster
  versions:
  - additionalPrinterColumns:
    - description: The Ingress Group name
      jsonPath: .spec.group.name
      name: GROUP-NAME
      type: string
    - description: The AWS Load Balancer scheme
      jsonPath: .spec.scheme
      name: SCHEME
      type: string
    - description: The AWS Load Balancer ipAddressType
      jsonPath: .spec.ipAddressType
      name: IP-ADDRESS-TYPE
      type: string
    - jsonPath: .metadata.creationTimestamp
      name: AGE
      type: date
    name: v1beta1
    schema:
      openAPIV3Schema:
        description: IngressClassParams is the Schema for the IngressClassParams API
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation
              of an object. Servers should convert recognized schemas to the latest
              internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this
              object represents. Servers may infer this from the endpoint the client
              submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: IngressClassParamsSpec defines the desired state of IngressClassParams
            properties:
              group:
                description: Group defines the IngressGroup for all Ingresses that
                  belong to IngressClass with this IngressClassParams.
                properties:
                  name:
                    description: Name is the name of IngressGroup.
                    type: string
                required:
                - name
                type: object
              ipAddressType:
                description: IPAddressType defines the ip address type for all Ingresses
                  that belong to IngressClass with this IngressClassParams.
                enum:
                - ipv4
                - dualstack
                type: string
              namespaceSelector:
                description: NamespaceSelector restrict the namespaces of Ingresses
                  that are allowed to specify the IngressClass with this IngressClassParams.
                  * if absent or present but empty, it selects all namespaces.
                properties:
                  matchExpressions:
                    description: matchExpressions is a list of label selector requirements.
                      The requirements are ANDed.
                    items:
                      description: A label selector requirement is a selector that
                        contains values, a key, and an operator that relates the key
                        and values.
                      properties:
                        key:
                          description: key is the label key that the selector applies
                            to.
                          type: string
                        operator:
                          description: operator represents a key's relationship to
                            a set of values. Valid operators are In, NotIn, Exists
                            and DoesNotExist.
                          type: string
                        values:
                          description: values is an array of string values. If the
                            operator is In or NotIn, the values array must be non-empty.
                            If the operator is Exists or DoesNotExist, the values
                            array must be empty. This array is replaced during a strategic
                            merge patch.
                          items:
                            type: string
                          type: array
                      required:
                      - key
                      - operator
                      type: object
                    type: array
                  matchLabels:
                    additionalProperties:
                      type: string
                    description: matchLabels is a map of {key,value} pairs. A single
                      {key,value} in the matchLabels map is equivalent to an element
                      of matchExpressions, whose key field is "key", the operator
                      is "In", and the values array contains only "value". The requirements
                      are ANDed.
                    type: object
                type: object
              scheme:
                description: Scheme defines the scheme for all Ingresses that belong
                  to IngressClass with this IngressClassParams.
                enum:
                - internal
                - internet-facing
                type: string
              tags:
                description: Tags defines list of Tags on AWS resources provisioned
                  for Ingresses that belong to IngressClass with this IngressClassParams.
                items:
                  description: Tag defines a AWS Tag on resources.
                  properties:
                    key:
                      description: The key of the tag.
                      type: string
                    value:
                      description: The value of the tag.
                      type: string
                  required:
                  - key
                  - value
                  type: object
                type: array
            type: object
        type: object
    served: true
    storage: true
    subresources: {}
EOT
)
}