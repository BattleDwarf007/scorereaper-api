module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.environment
  cidr = var.vpc_cidr

  azs                 = [local.production_availability_zones.az1, local.production_availability_zones.az2, local.production_availability_zones.az3]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  external_nat_ip_ids = ["eipalloc-0216a3a54bae0ac4e"]

  create_database_subnet_group = true

  default_route_table_tags   = { DefaultRouteTable = true }

  enable_dns_hostnames = true
  enable_dns_support   = true

  reuse_nat_ips       = true
  single_nat_gateway  = true

  enable_nat_gateway = true
  enable_vpn_gateway = false

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  tags = {
    Environment = "scorereaper"
  }
}


##########################################################
# Database server instance
##########################################################
module "ec2_db_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "db-node"

  ami           = local.images.linux
  instance_type = var.default_instance_type
  key_name      = var.ssh_keys.db
  monitoring    = false
  vpc_security_group_ids = ["sg-0481535e1fa0a5a1f"]
  subnet_id = module.vpc.database_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


##########################################################
# API server instance
##########################################################
module "ec2_api_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "test-api-node"

  ami           = local.images.linux
  instance_type = var.default_instance_type
  key_name      = var.ssh_keys.api
  monitoring    = false
  vpc_security_group_ids = ["sg-0dfb709ebe60d89a1","sg-0af98d063a02d1a77","sg-0481535e1fa0a5a1f","sg-0a248809a52f5564e"]
  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

##########################################################
# API server instance
##########################################################
module "ec2_grafana_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "grafana-node"

  ami           = local.images.linux
  instance_type = var.default_instance_type
  key_name      = var.ssh_keys.api
  monitoring    = false
  vpc_security_group_ids = ["sg-0dfb709ebe60d89a1","sg-0af98d063a02d1a77","sg-0481535e1fa0a5a1f","sg-0a248809a52f5564e"]
  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}