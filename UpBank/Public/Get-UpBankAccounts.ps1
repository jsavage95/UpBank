Function Get-UpBankAccounts{
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [ValidateScript({
            if(!(Ping-UpBankAPI -APIKey $_)){
                return $error
            }else{
                return $true
            }
        })]
        [System.String]
        $APIKey,

        [Parameter()]
        [System.String]
        $Uri = 'https://api.up.com.au/api/v1/accounts'
    )

    $headers = @{
        'Authorization' = "Bearer $APIKey"
    }

    $APIParams = @{
        Uri = $uri
        Headers = $headers
    }

    $Accounts = Invoke-RestMethod @APIParams

    return $Accounts
}