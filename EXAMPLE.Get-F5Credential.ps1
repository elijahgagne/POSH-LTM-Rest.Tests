function Get-F5Credential {
    $Username = "USERNAME_REMOVED"
    $SecurePassword = ConvertTo-SecureString "PASSWORD_REMOVED" -AsPlainText -Force
    New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)
}