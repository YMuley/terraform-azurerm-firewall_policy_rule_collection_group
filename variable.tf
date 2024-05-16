variable "azure_firewall_policy_rule_collection_group_list" {
  type    = list(any)
  default = []
}

variable "azure_firewall_policy_output" {
  type        = map(any)
  default     = {}
  description = "list of firewall objects "
}

variable "azure_firewall_network_rule_collection_output" {
  type        = map(any)
  default     = {}
  description = "list of azure firewall network rule collection objects "
}

variable "azure_firewall_nat_rule_collection_output" {
  type        = map(any)
  default     = {}
  description = "list of azure firewall nat rule collection objects "
}

variable "azure_firewall_application_rule_collection_output" {
  type        = map(any)
  default     = {}
  description = "list of azure firewall application rule collection objects "
}

variable "resource_group_output" {
  type        = map(any)
  default     = {}
  description = "list of resource group objects "
}

variable "default_values" {
  type        = any
  default     = {}
  description = "Provide default values for resource if not any"
}
