
resource "aws_security_group" "node_group" {
  count       = var.enabled ? 1 : 0
  name        = "${module.labels.id}-node-group"
  description = "Security Group for nodes Groups"
  vpc_id      = var.vpc_id
  tags        = module.labels.tags
}


#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "node_group" {
  count             = var.enabled ? 1 : 0
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.node_group[*].id)
  type              = "egress"
}


resource "aws_security_group_rule" "ingress_self" {
  count                    = var.enabled ? 1 : 0
  description              = "Allow nodes to communicate with each other"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  security_group_id        = join("", aws_security_group.node_group[*].id)
  source_security_group_id = join("", aws_security_group.node_group[*].id)
  type                     = "ingress"
}

resource "aws_security_group_rule" "ingress_security_groups_node_group" {
  count                    = var.enabled ? length(var.allowed_security_groups) : 0
  description              = "Allow inbound traffic from existing Security Groups"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = element(var.allowed_security_groups, count.index)
  security_group_id        = join("", aws_security_group.node_group[*].id)
  type                     = "ingress"
}

resource "aws_security_group_rule" "ingress_cidr_blocks_node_group" {
  count             = var.enabled && length(var.allowed_cidr_blocks) > 0 ? 1 : 0
  description       = "Allow inbound traffic from CIDR blocks"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.allowed_cidr_blocks
  security_group_id = join("", aws_security_group.node_group[*].id)
  type              = "ingress"
}