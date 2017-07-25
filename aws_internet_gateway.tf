#Provision Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  depends_on = ["aws_vpc.main"]

  tags {
    Name        = "${terraform.env} igw"
    Environment = "${lower(terraform.env)}"
    Stack       = "network"
  }
}
