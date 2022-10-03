//Chuyển tất cả output variable vào đây
output "ssh_command" {
  value = "ssh -i '${var.keyname}.pem' ec2-user@${aws_instance.web_golang.public_ip}"
}

output "web_site" {
  value = "http://${aws_instance.web_golang.public_ip}"
}