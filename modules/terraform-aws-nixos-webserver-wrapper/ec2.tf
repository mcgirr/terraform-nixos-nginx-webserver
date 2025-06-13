# Create a VPC to use with the web server
module "vpc" {
  # source  = "fpco/foundation/aws//modules/vpc"
  # version = "0.9.4"
  source    = "git::ssh://git@github.com/fpco/terraform-aws-foundation//modules/vpc?ref=312-vpc-and-subnets-IPv6-support"

  name_prefix          = var.name_prefix
  region               = var.region
  cidr                 = var.vpc_cidr
  extra_tags           = merge(var.extra_tags, var.vpc_extra_tags)
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  dns_servers          = var.dns_servers

  assign_generated_ipv6_cidr_block = "true"
}

# Public Subnet
module "public-subnet" {
  # source  = "fpco/foundation/aws//modules/subnets"
  # version = "0.9.4"
  source    = "git::ssh://git@github.com/fpco/terraform-aws-foundation//modules/subnet-ipv6?ref=312-vpc-and-subnets-IPv6-support"

  az          = var.az
  vpc_id      = module.vpc.vpc_id
  name_prefix = "${var.name_prefix}-public-subnet"
  cidr_block = var.public_subnet_cidr
  extra_tags  = merge(var.extra_tags, var.public_subnet_extra_tags)

  vpc_ipv6_cidr_block = module.vpc.ipv6_cidr_block
}

# Public Gateway
module "public-gateway" {
  # source  = "fpco/foundation/aws//modules/route-public"
  # version = "0.9.4"
  source    = "git::ssh://git@github.com/fpco/terraform-aws-foundation//modules/route-public?ref=312-vpc-and-subnets-IPv6-support"

  vpc_id            = module.vpc.vpc_id
  name_prefix       = "${var.name_prefix}-public-gateway"
  public_subnet_ids = [module.public-subnet.id]
  extra_tags        = merge(var.extra_tags, var.public_gateway_extra_tags)
}

# The SSH key for connecting to the web server
resource "aws_key_pair" "web_server_ssh_key" {
  key_name   = "${var.name_prefix}-web-server-ssh-key"
  public_key = file(var.ssh_pubkey)
}


# Create an instance for the web server to run from
resource "aws_instance" "web_server" {
  ami                     = var.web_server_ami
  instance_type           = var.web_server_type
  key_name                = aws_key_pair.web_server_ssh_key.key_name
  vpc_security_group_ids  = [module.web-server-sg.id]
  subnet_id               = module.public-subnet.id

  ipv6_address_count      = 1

  iam_instance_profile    = module.iam-web-server-instance-profile.iam_profile_id

  disable_api_termination = var.ec2_termination_protection
  # set based on need - false for dev true for prod

  # Nixos seems to only have user_data go to the configuration.nix location
  user_data = ""

  # lifecycle {
  #   ignore_changes = [
  #     user_data,
  #   ]
  # }

  root_block_device {
    volume_size = 20 # This is probably plenty enough for now
    delete_on_termination = true

    encrypted  = true
    kms_key_id = aws_kms_key.root.arn
  }

  # ebs_block_device cannot be mixed with external aws_ebs_volume and
  # aws_volume_attachment resources for a given instance.

  tags = {
    Name      = "${var.name_prefix}-web-server"
    Terraform = true
  }
}

# IAM role and instance profile for the web server
module "iam-web-server-instance-profile" {
  source  = "fpco/foundation/aws//modules/iam-instance-profile"
  version = "0.9.4"
  name_prefix = "${var.name_prefix}-web-server-instance-profile"
}
