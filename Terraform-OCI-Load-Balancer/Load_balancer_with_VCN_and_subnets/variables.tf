provider "oci" {
  tenancy_ocid     = "${var.tenancy_ocid}"
  region           = "${var.region}"
  user_ocid        = "${var.user_ocid}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
}

variable "tenancy_ocid" {} // Your tenancy's OCID
variable "region" {} // Which region is used in OCI eg. eu-frankfurt-1
variable "compartment_ocid" {}
variable "private_key_path" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "ssh_public_key" {
default = "C:/Users/megn/new.pub"
}

// VCN VARIABLES
variable "vcn_cidr_block" {
  default = "192.168.0.0/16"
} // Define the CIDR block for your OCI cloud

variable "display_name" {
  default = "My VCN"
} // VCN Name

variable "dns_label" {
  default = "oci"
} // DNS Label for VCN

// NAT GW VARIABLES
variable "nat_gateway_display_name" {
  default = "NatGateway"
} // Name for the NAT GW

variable "nat_gateway_block_traffic" {
  default = "false"
} // Is NAT GW active or not

// INTERNET GW VARIABLES

variable "internet_gateway_display_name" {
  default = "InternetGateway"
} // Name for the IGW

variable "internet_gateway_enabled" {
  default = "true"
} // Is IGW enabled or not

// PUBLIC AND PRIVATE ROUTETABLE VARIABLES

variable "public_route_table_display_name" {
  default = "PublicRoute"
} // Name for the public routetable

variable "private_route_table_display_name" {
  default = "PrivateRoute"
} // Name for the private routetable

variable "igw_route_cidr_block" {
  default = "0.0.0.0/0"
}

variable "natgw_route_cidr_block" {
  default = "0.0.0.0/0"
}

// PUBLIC AND PRIVATE SECURITYLIST VARIABLES

variable "public_sl_display_name" {
  default = "PublicSL"
} // Name for the public securitylist

variable "private_sl_display_name" {
  default = "PrivateSL"
} // Name for the private securitylist

variable "egress_destination" {
  default = "0.0.0.0/0"
} // Outside traffic is allowed

variable "tcp_protocol" {
  default = "6"
} // 6 for TCP traffic

variable "public_ssh_sl_source" {
  default = "0.0.0.0/0"
}

variable "public_http_sl_source" {
  default = "0.0.0.0/0"
}

variable "rule_stateless" {
  default = "false"
} // All rules are stateful by default so no need to define rules both ways

variable "public_sl_ssh_tcp_port" {
  default = "22"
} // Open port 22 for SSH access

variable "private_sl_ssh_tcp_port" {
  default = "22"
} // Open port 22 for SSH access

variable "private_sl_http_tcp_port" {
  default = "80"
} // Open port 80 for HTTP

variable "public_sl_http_tcp_port" {
  default = "80"
} // Open port 80 for HTTP

// PUBLIC AND PRIVATE SUBNET VARIABLES
variable "public_subnet_display_name" {
  default = "PublicSubnet"
} // Name for public subnet

variable "private_subnet_display_name" {
  default = "PrivateSubnet"
} // Name for private subnet

variable "public_subnet_dns_label" {
  default = "pub"
} // DNS Label for public subnet

variable "private_subnet_dns_label" {
  default = "pri"
} // DNS label for private subnet

variable "public_prohibit_public_ip_on_vnic" {
  default = "false"
} // Can instances in public subnet get public IP

variable "private_prohibit_public_ip_on_vnic" {
  default = "true"
} // Can instances in private subnet get public IP

// LOAD BALANCER VARIABLES

variable "lb_shape" {
  default = "100Mbps"
}

variable "lb_name" {
  default = "MyLB"
}

variable "lb_is_private" {
  default = false
}

variable "lb_be_name" {
  default = "MyLBBE1"
}

variable "lb_be_policy" {
  default = "ROUND_ROBIN"
}

variable "lb_be_health_checker_port" {
  default = "80"
}

variable "lb_be_health_checker_protocol" {
  default = "HTTP"
}

variable "lb_be_health_checker_regex" {
  default = ".*"
}

variable "lb_be_health_checker_urlpath" {
  default = "/index.html"
}

variable "lb_be_session_cookie" {
  default = "lb-session1"
}

variable "lb_be_session_fallback" {
  default = true
}

variable "lb_listener_name" {
  default = "MyHTTPListener"
}

variable "lb_listener_port" {
  default = 80
}

variable "lb_listener_protocol" {
  default = "HTTP"
}

variable "lb_listener_connection_configuration_idle_timeout" {
  default = "400"
}
