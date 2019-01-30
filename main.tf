// Shared Resource Group
resource "azurerm_resource_group" "shared" {
  name     = "${var.product}-${var.env}"
  location = "${var.location}"
  tags     = "${local.tags}"
}
