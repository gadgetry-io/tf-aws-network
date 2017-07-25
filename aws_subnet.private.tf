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

# PRIVATE SUBNETS ROUTE TABLES
resource "aws_route_table" "private_subnets" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${terraform.env} private rtb"
    Environment = "${lower(terraform.env)}"
    Stack       = "network"
  }
}

# PRIVATE SUBNETS ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "private_subnets" {
  count          = "${length(var.vpc_private_subnets_map)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_subnets.id}"
}

# DEFAULT ROUTE to NAT GATEWAY for PRIVATE SUBNETS
resource "aws_route" "private_subnet_ngw" {
  route_table_id         = "${aws_route_table.private_subnets.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.main.id}"
}
