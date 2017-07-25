resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${lower(terraform.env)}"
    Environment = "${lower(terraform.env)}"
    Stack       = "network"
  }
}
