output "mikemcgirr_web_server_ip_address" {
  value       = module.mikemcgirr-com-server.public_ip
  description = "The public IP of the web server"
}
