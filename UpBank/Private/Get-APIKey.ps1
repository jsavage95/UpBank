Function Get-APIKey {
    param(
        [Parameter()]
        [ValidateScript({
            if (Test-Path $_) { 
                $true 
            } else {
                throw "File path $_ does not exist!"
            }
        })]
        $APIFileKeyPath = "$((get-location).path)\APIKey.txt"
    )

    # Reading the encrypted string from the file
    $encryptedAPIKey = Get-Content -Path $APIFileKeyPath

    # Converting it to a SecureString object
    $secureAPIKey = ConvertTo-SecureString $encryptedAPIKey

    # Converting the SecureString to plain text
    $plainTextAPIKey = [System.Net.NetworkCredential]::new("", $secureAPIKey).Password

    # Returning the SecureString object
    return $plainTextAPIKey
}