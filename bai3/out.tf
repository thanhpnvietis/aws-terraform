

output "lb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.alb.lb_id
}

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.alb.lb_arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.alb.lb_dns_name
}
