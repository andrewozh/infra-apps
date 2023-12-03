# Required for managing aws-auth from module definition

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.20.0"

  create = var.avoid_billing ? false : true

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  #https://github.com/aws/karpenter/issues/1165
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    ingress_allow_karpenter_webhook_access_from_control_plane = {
      description                   = "Allow access from control plane to webhook port of karpenter"
      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }

  cluster_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    ingress_nodes_karpenter_ports_tcp = {
      description                = "Karpenter readiness"
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 0
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  eks_managed_node_groups = {
    main = {
      disk_size      = 10
      instance_types = [var.main_instance_type]
      min_size       = var.main_instance_count
      max_size       = var.main_instance_count
      desired_size   = var.main_instance_count
      capacity_type  = "ON_DEMAND"
      # iam_role_additional_policies = concat(
      #   ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"],
      #   var.policy_arns
      # )
    }
  }

  # create_aws_auth_configmap = true
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
