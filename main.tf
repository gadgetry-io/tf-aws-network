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
### RESOURCES
#####################

# CREATE VIRTUAL PRIVATE CLOUD

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "${var.vpc_name}"
  }
}

# CREATE DMZ SUBNETS FOR EACH AVAILABILITY ZONE

resource "aws_subnet" "dmz" {
  count                   = "${length(var.vpc_dmz_subnets)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(values(var.vpc_dmz_subnets), count.index)}"
  availability_zone       = "${element(keys(var.vpc_dmz_subnets), count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "DMZ ${var.vpc_name} ${element(keys(var.vpc_dmz_subnets), count.index)}"
  }
}

# CREATE PUBLIC SUBNETS FOR EACH AVAILABILITY ZONE

resource "aws_subnet" "public" {
  count                   = "${length(var.vpc_public_subnets)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(values(var.vpc_public_subnets), count.index)}"
  availability_zone       = "${element(keys(var.vpc_public_subnets), count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "PUBLIC ${var.vpc_name} ${element(keys(var.vpc_public_subnets), count.index)}"
  }
}

# CREATE PRIVATE SUBNETS FOR EACH AVAILABILITY ZONE

resource "aws_subnet" "private" {
  count             = "${length(var.vpc_private_subnets)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(values(var.vpc_private_subnets), count.index)}"
  availability_zone = "${element(keys(var.vpc_private_subnets), count.index)}"

  tags {
    Name = "PRIVATE ${var.vpc_name} ${element(keys(var.vpc_private_subnets), count.index)}"
  }
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
