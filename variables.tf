#####################
### INPUT VARIABLES
#####################
variable "aws_region" {
  type    = "string"
  default = "us-east-1"
}

variable "vpc_name" {
  type = "string"
}

variable "vpc_dhcp_domain_name" {
  type = "string"
}

variable "vpc_dhcp_domain_name_servers" {
  type    = "list"
  default = ["AmazonProvidedDNS"]
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.100.0.0/16"
}

variable "vpc_dmz_enabled" {
  type    = "string"
  default = true
}

variable "vpc_dmz_subnets" {
  type = "map"

  default = {
    us-east-1a = "10.100.21.0/24"
    us-east-1b = "10.100.22.0/24"
    us-east-1c = "10.100.23.0/24"
  }
}

variable "vpc_public_subnets" {
  type = "map"

  default = {
    us-east-1a = "10.100.11.0/24"
    us-east-1b = "10.100.12.0/24"
    us-east-1c = "10.100.13.0/24"
  }
}

variable "vpc_private_subnets" {
  type = "map"

  default = {
    us-east-1a = "10.100.1.0/24"
    us-east-1b = "10.100.2.0/24"
    us-east-1c = "10.100.3.0/24"
  }
}

#####################
### OUTPUT VARIABLES
#####################

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_name" {
  value = "${var.vpc_name}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

output "vpc_main_route_table_id" {
  value = "${aws_vpc.main.main_route_table_id}"
}

# SUBNET IDS
output "vpc_dmz_subnet_ids" {
  value = ["${aws_subnet.dmz.*.id}"]
}

output "vpc_public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "vpc_private_subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

# SUBNET AVAILABILITY ZONES
output "vpc_dmz_subnet_zones" {
  value = ["${aws_subnet.dmz.*.availability_zone}"]
}

output "vpc_public_subnet_zones" {
  value = ["${aws_subnet.public.*.availability_zone}"]
}

output "vpc_private_subnet_zones" {
  value = ["${aws_subnet.private.*.availability_zone}"]
}

# SUBNET CIDRS
output "vpc_dmz_subnet_cidrs" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "vpc_public_subnet_cidrs" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "vpc_private_subnet_cidrs" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

# ROUTE TABLES
output "vpc_dmz_route_table" {
  value = "${aws_route_table.dmz_subnets.id}"
}

output "vpc_public_route_table" {
  value = "${aws_route_table.public_subnets.id}"
}

output "vpc_private_route_table" {
  value = "${aws_route_table.private_subnets.id}"
}

# GATEWAYS
output "vpc_internet_gateway" {
  value = "${aws_internet_gateway.main.id}"
}

output "vpc_nat_gateway" {
  value = "${aws_nat_gateway.main.id}"
}
