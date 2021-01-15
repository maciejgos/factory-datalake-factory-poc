variable "resourceGroupName" {
  type = string
  default = "defaultResourceGroup"
}

variable "location" {
  type = string
  default = "westeurope"
}

variable "sqlAdminUser" {
  type = string
  default = "sqladmin"
}

variable "sqlAdminPassword" {}