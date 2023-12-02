data "aws_eks_cluster_auth" "default" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_certificate_authority_data
  token                  = data.aws_eks_cluster_auth.default.token
}

module "aws-auth" {
  source = "./aws-auth"

  create = var.avoid_billing ? false : true

  eks_managed_node_groups  = module.eks.eks_managed_node_groups
  self_managed_node_groups = module.eks.self_managed_node_groups
  fargate_profiles         = module.eks.fargate_profiles

  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true
  aws_auth_roles = [
    # {
    #   rolearn  = module.karpenter.role_arn
    #   username = "system:node:{{EC2PrivateDNSName}}"
    #   groups = [
    #     "system:bootstrappers",
    #     "system:nodes",
    #   ]
    # },
  ]
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::066477712859:user/andrew.ozhegov"
      username = "andrew.ozhegov"
      groups   = ["system:masters"]
    },
  ]
  # aws_auth_accounts = [
  #   "777777777777",
  #   "888888888888",
  # ]

  tags = var.tags_all
}
