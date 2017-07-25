#Provision Elastic IP for NAT Gateway
resource "aws_eip" "ngw" {
  vpc        = true
  depends_on = ["aws_vpc.main"]
}

#Provision NAT Gateway with Elastic IP
resource "aws_nat_gateway" "main" {
  allocation_id = "${aws_eip.ngw.id}"
  subnet_id     = "${aws_subnet.public.0.id}"
}
