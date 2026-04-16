locals {
  cloud_init_template_file = coalesce(var.cloud_init_template_file, "${path.module}/cloud-init/base.yaml.tpl")

  normalized_name_prefix = trim(lower(var.name_prefix), "-")
  dns_name_prefix        = substr(replace(local.normalized_name_prefix, "-", ""), 0, 10)

  vcn_display_name             = format("%s-vcn", local.normalized_name_prefix)
  subnet_display_name          = format("%s-subnet", local.normalized_name_prefix)
  internet_gateway_name        = format("%s-igw", local.normalized_name_prefix)
  route_table_name             = format("%s-route-table", local.normalized_name_prefix)
  security_list_name           = format("%s-security-list", local.normalized_name_prefix)
  instance_display_name_prefix = format("%s-vm", local.normalized_name_prefix)

  vcn_dns_label    = substr(format("%svcn", local.dns_name_prefix), 0, 15)
  subnet_dns_label = local.dns_name_prefix

  selected_availability_domain = var.availability_domain != null ? var.availability_domain : data.oci_identity_availability_domains.ads[0].availability_domains[0].name

  discovered_image_id   = try(data.oci_core_images.catalog.images[0].id, null)
  discovered_image_name = try(data.oci_core_images.catalog.images[0].display_name, null)

  selected_image_id   = local.discovered_image_id
  selected_image_name = local.discovered_image_name

  available_images_map = {
    for image in data.oci_core_images.catalog.images : image.display_name => image.id
  }
}

check "oci_private_key_input" {
  assert {
    condition     = !(var.private_key != null && var.private_key_path != null)
    error_message = "Set only one authentication input: private_key or private_key_path."
  }
}

data "oci_identity_availability_domains" "ads" {
  count          = var.availability_domain == null ? 1 : 0
  compartment_id = coalesce(var.tenancy_ocid, var.compartment_ocid)
}

data "oci_core_images" "catalog" {
  compartment_id = var.compartment_ocid

  operating_system         = "Canonical Ubuntu"
  operating_system_version = var.ubuntu_version
  state                    = "AVAILABLE"

  filter {
    name   = "display_name"
    values = ["^.*-aarch64-.*$"]
    regex  = true
  }

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}

resource "oci_core_virtual_network" "ampere_vcn" {
  cidr_block     = var.oci_vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = local.vcn_display_name
  dns_label      = local.vcn_dns_label
}

resource "oci_core_subnet" "ampere_subnet" {
  cidr_block        = var.oci_vcn_cidr_subnet
  display_name      = local.subnet_display_name
  dns_label         = local.subnet_dns_label
  security_list_ids = [oci_core_security_list.ampere_security_list.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.ampere_vcn.id
  route_table_id    = oci_core_route_table.ampere_route_table.id
  dhcp_options_id   = oci_core_virtual_network.ampere_vcn.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "ampere_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = local.internet_gateway_name
  vcn_id         = oci_core_virtual_network.ampere_vcn.id
}

resource "oci_core_route_table" "ampere_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.ampere_vcn.id
  display_name   = local.route_table_name

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ampere_internet_gateway.id
  }
}

resource "oci_core_security_list" "ampere_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.ampere_vcn.id
  display_name   = local.security_list_name

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  # Keep OCI-level ingress strict: SSH for admin + HTTP/HTTPS for apps.
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_instance" "ampere_a1" {
  count               = var.oci_vm_count
  availability_domain = local.selected_availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = format("%s-%02d", local.instance_display_name_prefix, count.index + 1)
  shape               = var.ampere_a1_shape

  lifecycle {
    precondition {
      condition     = local.selected_image_id != null
      error_message = "No Ubuntu AArch64 image matched. Adjust ubuntu_version."
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.ampere_subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = var.assign_public_ip
    hostname_label   = format("%s%02d", substr(local.dns_name_prefix, 0, 8), count.index + 1)
  }

  shape_config {
    memory_in_gbs = var.ampere_a1_vm_memory
    ocpus         = var.ampere_a1_cpu_core_count
  }

  source_details {
    source_type = "image"
    source_id   = local.selected_image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(file(local.cloud_init_template_file))
  }
}
