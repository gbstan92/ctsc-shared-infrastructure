//SHARED VARIABLES
variable "product" {
  description = "Product name for Courts and Tribunal Service Centres"
  default     = "ctsc"
}

variable "env" {
  description = "The deployment environment (sandbox, aat, prod etc..)"
}

variable "location" {
  description = "The location where you would like to deploy your infrastructure"
  default     = "UK South"
}

variable "product_group_object_id" {
  description = "Product group (dcd_group_ctsc_v2) object ID"
  default     = "075cc55b-c1d0-4fb9-a658-e5e0de0e13b1"
}

variable "subscription" {}

//KEY VAULT SPECIFIC VARIABLES
variable "tenant_id" {
  description = "The Tenant ID of the Azure Active Directory"
}

variable "jenkins_AAD_objectId" {
  description = "This is the ID of the Application you wish to give access to the Key Vault via the access policy"
}

// TAG SPECIFIC VARIABLES
variable "common_tags" {
  type = map(string)
}

variable "team_contact" {
  description = "The name of your Slack channel people can use to contact your team about your infrastructure"
  default     = "#ctsc-dev"
}

variable "managed_identity_object_id" {
  default = ""
}

// LOCALS
locals {
  tags = merge(
    var.common_tags,
    map("Team Contact", var.team_contact)
  )
}