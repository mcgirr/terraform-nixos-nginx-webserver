# The KMS key used to encrypt the root volume of the instance
resource "aws_kms_key" "root" {
  description = "The KMS key used to encrypt the root EBS volume for the ${var.base_domain} web server instance."

  tags = {
    Name = "${var.name_prefix}-root-volume-kms-key"
  }
}
