# DMZ SUBNETS FOR EACH AVAILABILITY ZONE
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

# DMZ PUBLIC SUBNETS ROUTE TABLE
resource "aws_route_table" "dmz_subnets" {
  count  = "${var.vpc_dmz_enabled}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${terraform.env} dmz rtb"
    Environment = "${lower(terraform.env)}"
    Stack       = "network"
  }

  depends_on = ["aws_subnet.dmz"]
}

# DMZ PUBLIC SUBNETS ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "dmz_subnets" {
  count          = "${length(var.vpc_dmz_subnets)}"
  subnet_id      = "${element(aws_subnet.dmz.*.id, count.index)}"
  route_table_id = "${aws_route_table.dmz_subnets.id}"
  depends_on     = ["aws_subnet.dmz"]
}

# DEFAULT ROUTE to INTERNET Gateway for dmz Subnets
resource "aws_route" "dmz_subnet_igw" {
  count                  = "${var.vpc_dmz_enabled}"
  route_table_id         = "${aws_route_table.dmz_subnets.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
  depends_on             = ["aws_subnet.dmz"]
}
