locals {
  mikemcgirr_dns_zone_name = "mikemcgirr.com"
  region = "us-west-2"
}

provider "aws" {
  version = "~> 2.18"
  region  = local.region
}

resource "aws_route53_zone" "mikemcgirr" {
  name = local.mikemcgirr_dns_zone_name
}

output "mikemcgirr_ns_records" {
  value       = aws_route53_zone.mikemcgirr.name_servers
  description = "The name server records for the mikemcgirr.com DNS zone."
}
