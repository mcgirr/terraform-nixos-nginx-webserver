# An ebs volume to mount that stores the existing emails
# resource "aws_ebs_volume" "mailbox" {
#   availability_zone = var.azs[0]
#   encrypted  = true
#   kms_key_id = aws_kms_key.mail.arn
#   size       = 60
#   tags = {
#     Name = "${var.name_prefix}-ebs-volume"
#   }
# }

# TODO review/setup
# This will be mounted to /var/vmail/
#
# Attach the email EBS volume to the instance
# resource "aws_volume_attachment" "mailbox" {

#   # The device name to expose to the instance (for example, /dev/sdh or xvdh).
#   device_name = "/dev/sdh"
#   # TODO change this or set up a way for it to be mounted by the instance where
#   # the mailserver puts the mail files
#   # https://www.terraform.io/docs/providers/aws/r/volume_attachment.html#device_name

#   volume_id   = aws_ebs_volume.mailbox.id
#   instance_id = aws_instance.email_server.id
# }

# # TODO review EBS snapshots
# # Create a snap of the EBS volume
# resource "aws_ebs_snapshot" "mailbox_snapshot" {
#   volume_id = aws_ebs_volume.mailbox.id
#
#   tags = {
#     Name = "${var.name_prefix}-ebs-volume-snapshot"
#   }
# }
