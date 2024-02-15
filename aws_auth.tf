

locals {


  map_worker_roles = [
    {
      rolearn : join("", aws_iam_role.node_groups[*].arn)
      username : "system:node:{{EC2PrivateDNSName}}"
      groups : [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]
}

resource "null_resource" "wait_for_cluster" {
  count      = var.enabled && var.apply_config_map_aws_auth ? 1 : 0
  depends_on = [aws_eks_cluster.default[0]]

  provisioner "local-exec" {
    command     = var.wait_for_cluster_command
    interpreter = var.local_exec_interpreter
    environment = {
      ENDPOINT = aws_eks_cluster.default[0].endpoint
    }
  }
}

data "aws_eks_cluster" "eks" {
  count = var.enabled && var.apply_config_map_aws_auth ? 1 : 0
  name  = join("", aws_eks_cluster.default[*].id)
}

data "aws_eks_cluster_auth" "eks" {
  count = var.enabled && var.apply_config_map_aws_auth ? 1 : 0
  name  = join("", aws_eks_cluster.default[*].id)
}

provider "kubernetes" {
  token                  = join("", data.aws_eks_cluster_auth.eks[*].token)
  host                   = join("", data.aws_eks_cluster.eks[*].endpoint)
  cluster_ca_certificate = base64decode(join("", data.aws_eks_cluster.eks[*].certificate_authority[0].data))
}

resource "kubernetes_config_map" "aws_auth_ignore_changes" {
  count      = var.enabled && var.apply_config_map_aws_auth ? 1 : 0
  depends_on = [null_resource.wait_for_cluster[0]]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles    = yamlencode(distinct(concat(local.map_worker_roles, var.map_additional_iam_roles)))
    mapUsers    = yamlencode(var.map_additional_iam_users)
    mapAccounts = yamlencode(var.map_additional_aws_accounts)
  }

  lifecycle {
    ignore_changes = [data["mapRoles"]]
  }
}
