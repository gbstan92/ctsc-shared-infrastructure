provider azurerm {
  features {}
}

resource "azurerm_resource_group" "shared" {
  name     = "${var.product}-${var.env}"
  location = var.location

  tags = local.tags
}

resource "azurerm_application_insights" "appinsights" {
  name                = "${var.product}-${var.env}"
  location            = azurerm_resource_group.shared.location
  resource_group_name = azurerm_resource_group.shared.name
  application_type    = "web"

  tags = local.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to appinsights as otherwise upgrading to the Azure provider 2.x
      # destroys and re-creates this appinsights instance
      application_type,
    ]
  }
}

module "vault" {
  source              = "git@github.com:hmcts/cnp-module-key-vault?ref=azurermv2"
  name                = "${var.product}-${var.env}"
  product             = var.product
  env                 = var.env
  tenant_id           = var.tenant_id
  object_id           = var.jenkins_AAD_objectId
  resource_group_name = azurerm_resource_group.shared.name

  product_group_object_id     = var.product_group_object_id
  common_tags                 = local.tags
  managed_identity_object_ids = [var.managed_identity_object_id]
  create_managed_identity     = true
}
