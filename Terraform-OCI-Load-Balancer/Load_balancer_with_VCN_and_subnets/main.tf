// Get available Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
  }

//Create a VCN where subnets will be placed. CIDR block can be defined as required

resource "oci_core_virtual_network" "CreateVCN" {
  cidr_block     = "${var.vcn_cidr_block}"
  dns_label      = "${var.dns_label}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.display_name}"
}

//Create NAT GW so private subnet will have access to Internet

resource "oci_core_nat_gateway" "CreateNatGateway" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.CreateVCN.id}"
  block_traffic  = "${var.nat_gateway_block_traffic}"
  display_name   = "${var.nat_gateway_display_name}"
}

//Create Internet Gateway for Public subnet

resource "oci_core_internet_gateway" "CreateIGW" {
  compartment_id = "${var.compartment_ocid}"
  enabled        = "${var.internet_gateway_enabled}"
  vcn_id         = "${oci_core_virtual_network.CreateVCN.id}"
  display_name   = "${var.internet_gateway_display_name}"
}

//Create two route tables - one public which has route to internet gateway and another one for private with a route to NAT GW

resource "oci_core_route_table" "CreatePublicRouteTable" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id       = "${oci_core_virtual_network.CreateVCN.id}"
  display_name = "${var.public_route_table_display_name}"

  route_rules {
    destination       = "${var.igw_route_cidr_block}"
    network_entity_id = "${oci_core_internet_gateway.CreateIGW.id}"
  }
}

resource "oci_core_route_table" "CreatePrivateRouteTable" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id       = "${oci_core_virtual_network.CreateVCN.id}"
  display_name = "${var.private_route_table_display_name}"

  route_rules {
    destination       = "${var.natgw_route_cidr_block}"
    network_entity_id = "${oci_core_nat_gateway.CreateNatGateway.id}"
  }
}

/*
Create two security lists - for both subnets we will allow traffic outside without restrictions
Public subnet will allow traffic for port 22
Private subnet will only allow traffic from Public subnet to ports 22 and 1521
*/

resource "oci_core_security_list" "CreatePublicSecurityList" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.CreateVCN.id}"
  display_name   = "${var.public_sl_display_name}"

  // Allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "${var.egress_destination}"
    protocol    = "${var.tcp_protocol}"
  }

  // allow inbound ssh traffic from a specific port
  ingress_security_rules  {
    protocol  = "${var.tcp_protocol}"         // tcp = 6
    source    = "${var.public_ssh_sl_source}" // Can be restricted for specific IP address
    #stateless = "${var.rule_stateless}"

    tcp_options {
      // These values correspond to the destination port range.
      min = "${var.public_sl_ssh_tcp_port}"
      max = "${var.public_sl_ssh_tcp_port}"
    }
  }
  ingress_security_rules   {
      protocol  = "${var.tcp_protocol}"          // tcp = 6
      source    = "${var.public_http_sl_source}" // Can be restricted for specific IP address
    # stateless = "${var.rule_stateless}"

      tcp_options {
        // These values correspond to the destination port range.
        min = "${var.public_sl_http_tcp_port}"
        max = "${var.public_sl_http_tcp_port}"
      }
    }
    ingress_security_rules {
      protocol  = "${var.tcp_protocol}"   // tcp = 6
      source    = "${var.vcn_cidr_block}" // open all ports for VCN CIDR and do not block subnet traffic
    # stateless = "${var.rule_stateless}"
    }
}

resource "oci_core_security_list" "CreatePrivateSecurityList" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.CreateVCN.id}"
  display_name   = "${var.private_sl_display_name}"

  // Allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "${var.egress_destination}"
    protocol    = "${var.tcp_protocol}"
  }

  // allow inbound traffic from VCN
  ingress_security_rules     {
      protocol  = "${var.tcp_protocol}"   // tcp = 6
      source    = "${var.vcn_cidr_block}" // VCN CIDR as allowed source and do not block subnet traffic
    #  stateless = "${var.rule_stateless}"

      tcp_options {
        // These values correspond to the destination port range.
        min = "${var.private_sl_ssh_tcp_port}"
        max = "${var.private_sl_ssh_tcp_port}"
      }
    }
    ingress_security_rules  {
      protocol  = "${var.tcp_protocol}"   // tcp = 6
      source    = "${var.vcn_cidr_block}" // open all ports for VCN CIDR and do not block subnet traffic
    #  stateless = "${var.rule_stateless}"

      tcp_options {
        // These values correspond to the destination port range.
        min = "${var.private_sl_http_tcp_port}"
        max = "${var.private_sl_http_tcp_port}"
      }
    }

}

//Create two subnets - one public where we will place a jump server and a another one where customer specific private resources are created

resource "oci_core_subnet" "CreatePublicSubnet" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr_block, 8, 0)}"
  display_name               = "${var.public_subnet_display_name}"
  dns_label                  = "${var.public_subnet_dns_label}"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_virtual_network.CreateVCN.id}"
  security_list_ids          = ["${oci_core_security_list.CreatePublicSecurityList.id}"]
  route_table_id             = "${oci_core_route_table.CreatePublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CreateVCN.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "${var.public_prohibit_public_ip_on_vnic}"
}

resource "oci_core_subnet" "CreatePublicSubnet2" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr_block, 8, 2)}"
  display_name               = "${var.public_subnet_display_name}"
  dns_label                  = "${var.public_subnet_dns_label}2"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_virtual_network.CreateVCN.id}"
  security_list_ids          = ["${oci_core_security_list.CreatePublicSecurityList.id}"]
  route_table_id             = "${oci_core_route_table.CreatePublicRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CreateVCN.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "${var.public_prohibit_public_ip_on_vnic}"
}

resource "oci_core_subnet" "CreatePrivateSubnet" {
  availability_domain        = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block                 = "${cidrsubnet(var.vcn_cidr_block, 8, 1)}"
  display_name               = "${var.private_subnet_display_name}"
  dns_label                  = "${var.private_subnet_dns_label}"
  compartment_id             = "${var.compartment_ocid}"
  vcn_id                     = "${oci_core_virtual_network.CreateVCN.id}"
  security_list_ids          = ["${oci_core_security_list.CreatePrivateSecurityList.id}"]
  route_table_id             = "${oci_core_route_table.CreatePrivateRouteTable.id}"
  dhcp_options_id            = "${oci_core_virtual_network.CreateVCN.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "${var.private_prohibit_public_ip_on_vnic}"
}

// Create Load Balancer

resource "oci_load_balancer" "CreateLoadBalancer" {
  shape          = "${var.lb_shape}"
  compartment_id = "${var.compartment_ocid}"

  subnet_ids = [
    "${oci_core_subnet.CreatePublicSubnet.id}",
    "${oci_core_subnet.CreatePublicSubnet2.id}",
  ]

  display_name = "${var.lb_name}"
  is_private   = "${var.lb_is_private}"
}

resource "oci_load_balancer_backend_set" "CreateLoadBalancerBackendSet" {
  name             = "${var.lb_be_name}"
  load_balancer_id = "${oci_load_balancer.CreateLoadBalancer.id}"
  policy           = "${var.lb_be_policy}"

  health_checker {
    port                = "${var.lb_be_health_checker_port}"
    protocol            = "${var.lb_be_health_checker_protocol}"
    response_body_regex = "${var.lb_be_health_checker_regex}"
    url_path            = "${var.lb_be_health_checker_urlpath}"
  }

  session_persistence_configuration {
    cookie_name      = "${var.lb_be_session_cookie}"
    disable_fallback = "${var.lb_be_session_fallback}"
  }
}

resource "oci_load_balancer_listener" "CreateListener" {
  load_balancer_id         = "${oci_load_balancer.CreateLoadBalancer.id}"
  name                     = "${var.lb_listener_name}"
  default_backend_set_name = "${oci_load_balancer_backend_set.CreateLoadBalancerBackendSet.name}"

  #hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}", "${oci_load_balancer_hostname.test_hostname2.name}"]
  port     = "${var.lb_listener_port}"
  protocol = "${var.lb_listener_protocol}"

  #rule_set_names           = ["${oci_load_balancer_rule_set.test_rule_set.name}"]

  connection_configuration {
    idle_timeout_in_seconds = "${var.lb_listener_connection_configuration_idle_timeout}"
  }
}
