resource "aws_route53_zone" "vpc_public" {
  name    = "${terraform.env}.${var.vpc_dhcp_domain_name}."
  comment = "Managed by Terraform. Public ${terraform.env} Public Zone"
}
