# --- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.app_rds_subnetgroup.*.name
}

output "db_security_group" {
  value = [aws_security_group.app_sg["rds"].id]
}

output "app_security_group" {
  value = [aws_security_group.app_sg["app"].id]
}

output "private_subnet_ids" {
  value = aws_subnet.app_private_subnet.*.id
}
