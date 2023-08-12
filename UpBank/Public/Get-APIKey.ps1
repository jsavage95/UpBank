<#
.SYNOPSIS
Retrieves and decrypts the stored UpBank API key from a specified folder path.

.DESCRIPTION
The Get-APIKey function retrieves the UpBank API key from a file named "UpBankAPIKey.txt" within the specified folder path.
It decrypts the secure string stored in the file and returns the plain text API key.

.PARAMETER FolderPath
The folder path where the "UpBankAPIKey.txt" file is stored. The path must be valid, and the file must exist within the specified directory.

.EXAMPLE
$apiKey = Get-APIKey -FolderPath 'C:\path\to\folder'
Retrieves the API key from the "UpBankAPIKey.txt" file within the specified folder path and stores it in the $apiKey variable.

.LINK
Set-APIKeyToFile
#>

Function Get-APIKey {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript({
            $pathWithFile = Join-Path -Path $_ -ChildPath 'UpBankAPIKey.txt'
            if (Test-Path $pathWithFile) { 
                $true 
            } else {
                throw "File path $pathWithFile does not exist!"
            }
        })]
        [string]$FolderPath
    )

    # Combining folder path with default file name
    $APIFileKeyPath = Join-Path -Path $FolderPath -ChildPath 'UpBankAPIKey.txt'

    # Reading the encrypted string from the file
    $encryptedAPIKey = Get-Content -Path $APIFileKeyPath

    # Converting it to a SecureString object
    $secureAPIKey = ConvertTo-SecureString $encryptedAPIKey

    # Converting the SecureString to plain text
    $plainTextAPIKey = [System.Net.NetworkCredential]::new("", $secureAPIKey).Password

    # Returning the plain text API key
    return $plainTextAPIKey
}
