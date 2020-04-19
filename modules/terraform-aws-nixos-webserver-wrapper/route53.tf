# DNS Zone
data "aws_route53_zone" "primary" {
  name = "${var.base_domain}"
}

# DNS records for the web server

# IPv4
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "www.${var.base_domain}."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.web_server.public_ip ]
}

# IPv6
resource "aws_route53_record" "www6" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "www.${var.base_domain}."
  type    = "AAAA"
  ttl     = "300"
  records = [ aws_instance.web_server.ipv6_addresses[0] ]
}

# IPv4
resource "aws_route53_record" "a" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.base_domain}."
  type    = "A"
  ttl     = "300"
  records = [ aws_eip.web_server.public_ip ]
}

# IPv6
resource "aws_route53_record" "aaaa" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.base_domain}."
  type    = "AAAA"
  ttl     = "300"
  records = [ aws_instance.web_server.ipv6_addresses[0] ]
}
