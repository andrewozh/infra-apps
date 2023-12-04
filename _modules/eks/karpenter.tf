module "karpenter" {
  source = "./karpenter"

  avoid_billing = var.avoid_billing

  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  irsa_oidc_provider_arn = module.eks.oidc_provider_arn
  iam_role_arn           = module.eks.eks_managed_node_groups.main.iam_role_arn
  iam_role_name          = module.eks.eks_managed_node_groups.main.iam_role_name

  tags = var.tags_all
}
