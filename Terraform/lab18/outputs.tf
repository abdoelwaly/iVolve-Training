output "nginx_public_ip" {
  value = aws_eip.nginx_eip.public_ip
}

output "ec2_private_ips" {
  value = {
    nginx  = aws_instance.nginx.private_ip
    apache = aws_instance.apache.private_ip
  }
}