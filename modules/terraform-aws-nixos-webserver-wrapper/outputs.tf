output "public_ip" {
  value       =  aws_instance.web_server.public_ip
  description = "The public IP of the web server"
}
