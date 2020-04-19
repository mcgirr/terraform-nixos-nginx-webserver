# Security group for the web server
module "web-server-sg" {
  source      = "fpco/foundation/aws//modules/security-group-base"
  version     = "0.9.4"
  description = "The security group for the ${var.name_prefix} web server"
  name        = "${var.name_prefix}-web-server-sg"
  vpc_id      = module.vpc.vpc_id
}

# security group rule for inbound SSH to the web server
module "web-server-ssh-rule" {
  source            = "fpco/foundation/aws//modules/ssh-sg"
  version           = "0.9.4"
  cidr_blocks       = ["0.0.0.0/0" ]
  # ipv6_cidr_blocks  = ["::/0" ] # TODO add ipv6 to the upstream module
  security_group_id = module.web-server-sg.id
}

module "web-server-open-egress-rule" {
  # source            = "fpco/foundation/aws//modules/open-egress-sg"
  # version           = "0.9.4"
  source    = "git::ssh://git@github.com/fpco/terraform-aws-foundation//modules/open-egress-sg?ref=312-vpc-and-subnets-IPv6-support"

  description       = "Security group rule for web server open egress (outbound from the web server instance)"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = module.web-server-sg.id
}

# 80  HTTP
# 443 HTTPS
# 22  SSH

# security group rule for HTTP the web server
module "web-server-http-rule" {
  # source            = "fpco/foundation/aws//modules/single-port-sg"
  # version           = "0.9.4"
  source    = "git::ssh://git@github.com/fpco/terraform-aws-foundation//modules/single-port-sg?ref=312-vpc-and-subnets-IPv6-support"

  description       = "Allow HTTP access on port 80"
  port              = 80
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0" ]
  security_group_id = module.web-server-sg.id
}

# security group rule for HTTPS the web server
module "web-server-https-rule" {
  # source            = "fpco/foundation/aws//modules/single-port-sg"
  # version           = "0.9.4"
  source    = "git::ssh://git@github.com/fpco/terraform-aws-foundation//modules/single-port-sg?ref=312-vpc-and-subnets-IPv6-support"

  description       = "Allow HTTPS access on port 443"
  port              = 443
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0" ]
  security_group_id = module.web-server-sg.id
}

# TODO add ping icmp 
