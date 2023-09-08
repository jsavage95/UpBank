Function Get-UpBankCategories{
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
        $Uri = 'https://api.up.com.au/api/v1/categories'
    )

    $headers = @{
        'Authorization' = "Bearer $APIKey"
    }

    $APIParams = @{
        Uri = $uri
        Headers = $headers
    }

    $Categories = Invoke-RestMethod @APIParams

    return $Categories
}