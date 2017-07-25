#####################
### INPUT VARIABLES
#####################

variable "vpc_name" {}

variable "vpc_cidr" {}

variable "vpc_dmz_subnets" {
  type = "map"
}

variable "vpc_public_subnets" {
  type = "map"
}

variable "vpc_private_subnets" {
  type = "map"
}

#####################
### OUTPUT VARIABLES
#####################

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

output "vpc_main_route_table_id" {
  value = "${aws_vpc.main.main_route_table_id}"
}

output "vpc_dmz_subnet_ids" {
  value = ["${aws_subnet.dmz.*.id}"]
}

output "vpc_public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "vpc_private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "vpc_dmz_subnet_zones" {
  value = ["${aws_subnet.dmz.*.availability_zone}"]
}

output "vpc_public_subnet_zones" {
  value = ["${aws_subnet.public.*.availability_zone}"]
}

output "vpc_private_subnet_zones" {
  value = ["${aws_subnet.private.*.availability_zone}"]
}

output "vpc_dmz_subnet_cidrs" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "vpc_public_subnet_cidrs" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "vpc_private_subnet_cidrs" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "vpc_name" {
  value = "${var.vpc_name}"
}
