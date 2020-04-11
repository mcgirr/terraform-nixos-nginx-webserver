provider "aws" {
  version = "~> 2.18"
  region  = local.region
}

module "mikemcgirr-com-server" {
  source = "../modules/mikemcgirr-com-webserver-aws-wrapper"

  name_prefix = local.name_prefix
  base_domain = local.base_domain
  hostname    = local.hostname
  region      = local.region

  email = var.email

  vpc_cidr           = local.vpc_cidr
  public_subnet_cidr = local.public_subnet_cidr

  # If true, enables EC2 Instance Termination Protection
  ec2_termination_protection = local.web_server_termination_protection

  web_server_type = local.web_server_type
  web_server_ami  = local.web_server_ami

  ssh_pubkey = local.ssh_pubkey

  # DNS
  enable_dns_hostnames = local.enable_dns_hostnames
  enable_dns_support   = local.enable_dns_support
  dns_servers          = local.dns_servers

  # AZ
  az = local.az
}
