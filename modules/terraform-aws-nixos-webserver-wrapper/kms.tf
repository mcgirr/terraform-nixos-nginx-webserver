# The KMS key used to encrypt the root volume of the instance
resource "aws_kms_key" "root" {
  description = "The KMS key used to encrypt the root EBS volume for the ${var.base_domain} web server instance."

  # policy = TODO

  tags = {
    Name = "${var.name_prefix}-root-volume-kms-key"
  }
}

# TODO see https://www.terraform.io/docs/providers/aws/r/ebs_default_kms_key.html
# resource "aws_ebs_default_kms_key" "example" {
#   key_arn = "${aws_kms_key.example.arn}"
# }
