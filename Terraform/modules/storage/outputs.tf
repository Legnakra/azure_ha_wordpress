output "diagnostics_storage_account_endpoint" {
  value = azurerm_storage_account.vm_diagnostics.primary_blob_endpoint
}