# Render a file to copy at the very beginning of setting up the webserver
resource "local_file" "nix_configuration" {
  content = templatefile("${path.module}/templates/configuration.nix.tpl", {
    domain            = var.base_domain
    email             = var.email
    hostname          = var.hostname
    content_location  = var.content_location
  })
  filename = "${path.root}/configuration.nix"
  file_permission = "0600"
}

resource "local_file" "init_configuration" {
  content = templatefile("${path.module}/templates/init.sh.tpl", {
    ip                = aws_eip.web_server.public_ip
    content_location  = var.content_location
  })

  filename = "${path.root}/init.sh"
  file_permission = "0700"
}
