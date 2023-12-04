module "karpenter" {
  source = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "19.20.0"

  create = var.avoid_billing ? false : true

  cluster_name = var.cluster_name

  irsa_oidc_provider_arn          = var.irsa_oidc_provider_arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]
  irsa_use_name_prefix            = false

  create_iam_role      = false
  iam_role_arn         = var.iam_role_arn

  enable_karpenter_instance_profile_creation = true

  tags = var.tags
}

data "aws_ecrpublic_authorization_token" "token" {}

resource "helm_release" "karpenter" {
  namespace        = var.karpenter_namespace
  create_namespace = true

  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart               = "karpenter"
  version             = var.karpenter_chart_version

  values = [
    <<-EOT
    settings:
      clusterName: ${var.cluster_name}
      clusterEndpoint: ${var.cluster_endpoint}
      interruptionQueueName: ${module.karpenter.queue_name}
      defaultInstanceProfile: ${module.karpenter.instance_profile_name}
    serviceAccount:
      annotations:
        eks.amazonaws.com/role-arn: ${module.karpenter.irsa_arn}
    EOT
  ]

  lifecycle {
    ignore_changes = [repository_password]
  }

  depends_on = [
    module.karpenter
  ]
}

resource "local_file" "karpenter_node_class" {
  filename = "${path.module}/nodeclass.yaml"
  content = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: default
    spec:
      amiFamily: AL2
      role: "${var.iam_role_name}"
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: "${var.cluster_name}"
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: "${var.cluster_name}"
      tags:
        karpenter.sh/discovery: "${var.cluster_name}"
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}

resource "local_file" "karpenter_node_pool" {
  filename = "${path.module}/nodepool.yaml"
  content = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: default
    spec:
      template:
        spec:
          nodeClassRef:
            name: default
          requirements:
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["c", "m", "r"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["4", "8", "16", "32"]
            - key: "karpenter.k8s.aws/instance-hypervisor"
              operator: In
              values: ["nitro"]
            - key: "karpenter.k8s.aws/instance-generation"
              operator: Gt
              values: ["2"]
      limits:
        cpu: 1000
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 30s
  YAML

  depends_on = [
    # kubectl_manifest.karpenter_node_class,
    helm_release.karpenter
  ]
}
