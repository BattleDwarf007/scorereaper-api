module "api_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "api-server"
  description = "Security group for api-server with HTTPs ports open within VPC"
  vpc_id      = data.aws_vpc.selected.id

  ingress_cidr_blocks = ["10.10.0.0/16"]
}

module "http_mysql_2_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "http-mysql-2"
  description = "Security group with HTTP and MySQL ports open within current VPC"
  vpc_id      = data.aws_vpc.selected.id

  # Add mysql rules
  ingress_rules = ["mysql-tcp"]

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_blocks      = [data.aws_vpc.selected.cidr_block]
}

resource "aws_security_group" "cloudflare" {
  name        = "cloudflare_sg"
  description = "Allow access from cloudflare"
  vpc_id = data.aws_vpc.selected.id
}


module "cloudflare-ips" {
  source = "orzarchi/cloudflare-security-group/aws"

  security_group_id = aws_security_group.cloudflare.id
  enabled= "true"
}
