<#
.SYNOPSIS
Secures and stores the UpBank API key in a text file.

.DESCRIPTION
The Set-APIKeyToFile function takes an API key and a folder path as input.
It converts the API key to a secure string and stores it in a text file named "UpBankAPIKey.txt" within the specified folder path.
This securely stored API key can later be retrieved using the Get-APIKey function, converted back to plain text, and passed to other functions like Get-UpBankTransactions.

Note: The key stored by this function can only be imported by the user who ran the function, and only on the machine where it was run.

.PARAMETER APIKey
The plain text API key to be secured and stored.

.PARAMETER FolderPath
The folder path where the "UpBankAPIKey.txt" file will be stored. The path must be valid, and the directory must exist.

.EXAMPLE
Set-APIKeyToFile -APIKey 'your-api-key-here' -FolderPath 'C:\path\to\folder'
Stores the specified API key in the "UpBankAPIKey.txt" file within the specified folder path.

.LINK
Get-APIKey
#>

function Set-APIKeyToFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$APIKey,

        [Parameter(Mandatory = $true)]
        [ValidateScript({
            if (Test-Path -Path $_ -PathType Container) {
                $true
            } else {
                throw "Directory not found at the path '$_'."
            }
        })]
        [string]$FolderPath
    )

    # Convert the API key to a secure string
    $secureAPIKey = ConvertTo-SecureString $APIKey -AsPlainText -Force

    # Define the default file name
    $fileName = "UpBankAPIKey.txt"

    # Combine the folder path and file name
    $filePath = Join-Path -Path $FolderPath -ChildPath $fileName

    # Write the secure API key to the file
    $secureAPIKey | ConvertFrom-SecureString | Set-Content -Path $filePath
}
