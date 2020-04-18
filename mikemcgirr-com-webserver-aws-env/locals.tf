locals {
  name_prefix = "mikemcgirr"
  base_domain = "${local.name_prefix}.com"
  hostname    = "mikemcgirr"
  region      = "us-west-2"

  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = cidrsubnet(local.vpc_cidr, 8, 15)

  # webserver EC2
  web_server_termination_protection = "false"
  # If true, enables EC2 Instance Termination Protection

  web_server_type = "t3a.medium"
  web_server_ami  = "ami-02d9a19f77b47882a"
  # This is using the latest NixOS AMI in us-west-2 and is for NixOS 19.09
  # See https://nixos.org/nixos/download.html

  ssh_pubkey = "./id_rsa.pub"

  # DNS
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  dns_servers          = ["AmazonProvidedDNS"]

  # AZ
  az      = data.aws_availability_zones.available.names[0]
}
