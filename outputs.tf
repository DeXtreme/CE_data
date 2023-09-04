output "urls" {
  value = [for instance in aws_instance.instance : instance.public_dns]
}