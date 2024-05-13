locals {
  azure_firewall_policy_rule_collection_group = { for azure_firewall_policy_rule_collection_group in var.azure_firewall_policy_rule_collection_group_list : azure_firewall_policy_rule_collection_group.name => azure_firewall_policy_rule_collection_group }
}
