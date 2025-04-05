output "nlb_dns_name" {
  description = "NLB public DNS name"
  value       = aws_lb.nlb.dns_name
}

output "api_url" {
  value = "http://api.${var.domain_name}"
}

output "mysql_private_ip" {
  description = "Private IP of MySQL instance"
  value       = aws_instance.mysql.private_ip
}
