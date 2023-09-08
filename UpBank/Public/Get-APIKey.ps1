<#
.SYNOPSIS
Retrieves and decrypts the stored UpBank API key from a specified folder path.

.DESCRIPTION
The Get-APIKey function retrieves the UpBank API key from a file within the specified folder path.
It decrypts the secure string stored in the file and returns the plain text API key.

.PARAMETER FolderPath
The folder path where the encrypted password file is stored. The path must be valid, and the file must exist within the specified directory.

.PARAMETER FileName
The name of the file containing the encrypted password

.EXAMPLE
$apiKey = Get-APIKey -FolderPath 'C:\path\to\folder'
Retrieves the API key from the "UpBankAPIKey.txt" file within the specified folder path and stores it in the $apiKey variable.


.LINK
Set-APIKeyToFile
#>

Function Get-APIKey {
    param(
        [Parameter(Mandatory)]
        [System.String]
        $FolderPath,

        [Parameter(Mandatory)]
        [System.String]
        $FileName
    )

    #Path Validation
    $FullFilePath = Join-Path -Path $FolderPath -ChildPath $FileName
    if (!(Test-Path $FullFilePath)) { 
        throw "File path $pathWithFile does not exist!"
    } 

    # Combining folder path with default file name
    $APIFileKeyPath = Join-Path -Path $FolderPath -ChildPath $FileName

    # Reading the encrypted string from the file
    $encryptedAPIKey = Get-Content -Path $APIFileKeyPath

    # Converting it to a SecureString object
    $secureAPIKey = ConvertTo-SecureString $encryptedAPIKey

    # Converting the SecureString to plain text
    $plainTextAPIKey = [System.Net.NetworkCredential]::new("", $secureAPIKey).Password

    # Returning the plain text API key
    return $plainTextAPIKey
}
