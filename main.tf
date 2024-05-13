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

}
