resource "azurerm_firewall_policy_rule_collection_group" "azure_firewall_policy_rule_collection_group" {
  for_each           = local.azure_firewall_policy_rule_collection_group
  name               = each.value.name
  firewall_policy_id = each.value.firewall_policy_name == null ? null : var.azure_firewall_policy_output[each.value.firewall_policy_name].id
  priority           = each.value.priority

  dynamic "application_rule_collection" {
    for_each = each.value.application_rule_collection_list
    content {
      name     = application_rule_collection.value.name
      action   = application_rule_collection.value.action
      priority = application_rule_collection.value.priority

      dynamic "rule" {
        for_each = application_rule_collection.value.rule_list
        content {
          name              = rule.value.name
          source_addresses  = rule.value.source_addresses
          destination_fqdns = rule.value.destination_fqdns

          dynamic "protocols" {
            for_each = rule.value.protocols_list
            content {
              port = protocols.value.port
              type = protocols.value.type

            }
          }
        }
      }
    }
  }

  # dynamic "nat_rule_collection" {
  #   for_each = each.value.azure_firewall_nat_rule_collection_list
  #   content {
  #     action   = nat_rule_collection.value.action
  #     name     = nat_rule_collection.value.name
  #     priority = nat_rule_collection.value.priority

  #     dynamic "rule" {
  #       for_each = nat_rule_collection.value.rule_list
  #       content {

  #         destination_address = rule.value.destination_address
  #         destination_ports   = rule.value.destination_ports
  #         name                = rule.value.name
  #         protocols           = rule.value.protocols
  #         source_addresses    = rule.value.source_addresses
  #         source_ip_groups    = rule.value.source_ip_groups
  #         translated_address  = rule.value.translated_address
  #         translated_port     = rule.value.translated_port
  #       }
  #     }

  #   }
  # }

  dynamic "network_rule_collection" {
    for_each = each.value.network_rule_collection_list
    content {

      action   = network_rule_collection.value.action
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority

      dynamic "rule" {
        for_each = network_rule_collection.value.rule_list
        content {

          destination_addresses = rule.value.destination_addresses
          destination_fqdns     = rule.value.destination_fqdns
         // destination_ip_groups = rule.value.destination_ip_groups
          destination_ports     = rule.value.destination_ports
          name                  = rule.value.name
          protocols             = rule.value.protocols
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
        }
      }
    }
  }
}
