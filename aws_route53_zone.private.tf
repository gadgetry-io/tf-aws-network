###############################################################################
### ROUTE53 PRIVATE HOSTED ZONE                                             ###
###############################################################################

# CREATE PRIVATE HOSTED ZONE
resource "aws_route53_zone" "vpc_private" {
  name    = "${terraform.env}.${var.vpc_dhcp_domain_name}."
  vpc_id  = "${aws_vpc.main.id}"
  comment = "Managed by Terraform. Private ${terraform.env} Hosted Zone"
}

# PROVISION PRIVATE DNS ROUTES USING ROUTE53_SUBNET_SEEDER
resource "null_resource" "basic_dns" {
  count = "${length(values(var.vpc_private_subnets_map))}"

  triggers {
    subnet              = "${element(values(var.vpc_private_subnets_map),count.index)}"
    forward_lookup_zone = "${aws_route53_zone.vpc_private.id}"
  }

  provisioner "local-exec" {
    command = "${path.module}/../../files/route53_subnet_seeder -c ${element(values(var.vpc_private_subnets_map),count.index)} -f ${aws_route53_zone.vpc_private.id} -a UPSERT --verbose"
  }
}

# PROVISION PUBLIC DNS ROUTES USING ROUTE53_SUBNET_SEEDER
resource "null_resource" "basic_dns_public" {
  count = "${length(values(var.vpc_public_subnets_map))}"

  triggers {
    subnet              = "${element(values(var.vpc_public_subnets_map),count.index)}"
    forward_lookup_zone = "${aws_route53_zone.vpc_private.id}"
  }

  provisioner "local-exec" {
    command = "${path.module}/../../files/route53_subnet_seeder -c ${element(values(var.vpc_public_subnets_map),count.index)} -f ${aws_route53_zone.vpc_private.id} -a UPSERT --verbose"
  }
}
