variable "region" {
  type    = string
  default = "af-south-1"
}

variable "default_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ssh_keys" {
  description = "EC2 ssh keys"
  type        = map(string)
  default = {
    db  = "db_server"
    api = "api_server"
  }
}

variable "subnets" {
  type = map(string)
  default = {
    public  = "subnet-026d83dce4cdd40ff"
    private = "subnet-0c1e17daf3ef63ea7"
  }
}

variable "environment" {
  default = "battledwarf"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_subnets_cidr" {
  default = "10.0.2.0/28"
}
variable "private_subnets_cidr" {
  default = "10.0.1.0/24"
}

variable "vpc_name" {
  default = "battledwarf"
}

variable "vpc_id" {
  default = "vpc-08adaa856a02007c3"
}


variable "vpn_allowed_cidrs" {
  description = "List of the subnets to which the VPN clients will be allowed access to (in CIDR notation)."
  type        = list(string)
  default     = ["10.0.2.0/28", "10.0.1.0/24"]
}

variable "vpn_cidr" {
  description = "The subnet for the VPN clients (in CIDR notation)."
  default     = "172.16.61.0/24"
  type        = string
}

variable "vpn_dns" {
  description = "List of DNS Server addresses."
  default     = []
  type        = list(string)
}

variable "root_volume_iops" {
  description = "The amount of provisioned IOPS (for 'io1' type only)."
  default     = 0
  type        = string
}

variable "root_volume_size" {
  description = "The volume size in gigabytes."
  default     = "8"
  type        = string
}

variable "root_volume_type" {
  description = "The volume type. Must be one of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
  default     = "gp2"
  type        = string
}

variable "allow_nat" {
  description = "Should there be nat possibility"
  default     = true
  type        = bool
}

variable "allow_ssh_port" {
  description = "Should the ssh port be open"
  default     = true
  type        = bool
}

variable "ssh_cidr" {
  description = "Allowd nbetwork range for SSH"
  type        = list(string)
  default = [
    "0.0.0.0/0"
  ]
}

variable "cidr" {
  description = "Ingress IP range for NAT"
  default     = "0.0.0.0/0"
  type        = string
}