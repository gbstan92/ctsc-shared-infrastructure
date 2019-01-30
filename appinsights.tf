resource "azurerm_application_insights" "appinsights" {
  name                = "${var.product}-${var.env}"
  location            = "${var.appinsights_location}"
  resource_group_name = "${azurerm_resource_group.shared.name}"
  application_type    = "${var.application_type}"
  tags                = "${local.tags}"
}