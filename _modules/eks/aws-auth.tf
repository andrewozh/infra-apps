module "eks_auth" {
  source = "aidanmelen/eks-auth/aws"
  version = "1.0.0"

  eks    = module.eks

  map_users = [
    {
      userarn  = "arn:aws:iam::066477712859:user/andrew.ozhegov"
      username = "andrew.ozhegov"
      groups   = ["system:masters"]
    },
  ]
}
