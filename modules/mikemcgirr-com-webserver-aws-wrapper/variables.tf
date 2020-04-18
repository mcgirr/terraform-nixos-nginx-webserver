variable "name_prefix" {
  description = "Name prefix to name of resources created"
  type        = string
}

variable "base_domain" {
  description = "The domain that will be served"
  type        = string
}

variable "hostname" {
  description = "The hostname to set on the AWS instance"
  type        = string
}

variable "email" {
  description = "The email to use for the cert emails."
  type        = string
}

variable "region" {
  description = "The region to create AWS resources in for the web server"
  type        = string
}

variable "vpc_cidr" {
  description = "The VPC CIDR block"
  type = string
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR value for the public subnet"
  type        = string
}

variable "public_subnet_extra_tags" {
  description = "Extra tags that will be added to public subnets."
  default     = {}
  type        = map
}

variable "public_gateway_extra_tags" {
  description = "Extra tags that will be added to Internet Gateway and public Routing Tables."
  default     = {}
  type        = map
}

variable "ssh_pubkey" {
  description = "File path to SSH public key"
  type = string
}

variable "ec2_termination_protection" {
  description = "EC2 Termination proctection is enabled if true."
  type = bool
}

variable "web_server_type" {
  description = "AWS instance type for the web server."
  type = string
}

variable "web_server_ami" {
  description = "The AMI of the web server. This will probably be the most recent NixOS AMI."
  type = string
}

# DNS

# For docs see https://docs.aws.amazon.com/vpc/latest/userguide/vpc-dns.html#vpc-dns-hostnames
# or https://www.terraform.io/docs/providers/aws/r/vpc.html#enable_dns_hostnames
variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = string
}

variable "dns_servers" {
  description = "List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to AmazonProvidedDNS"
  type        = list
}

variable "az" {
  description = "A list of Availaiblity Zones in the region"
  type        = string
}

variable "vpc_extra_tags" {
  description = "Extra tags that will be added to VPC and DHCP Options. Note that duplicate keys will overwrite those from the extra_tags variable."
  default     = {}
  type        = map
}

variable "extra_tags" {
  description = "Extra tags that will be added to all resources."
  default     = {}
  type        = map
}
