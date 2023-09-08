Function Get-UpBankTags{
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
        $PageSize = '2',

        [Parameter()]
        [System.String]
        $Uri = 'https://api.up.com.au/api/v1/tags'
    )

    $headers = @{
        'Authorization' = "Bearer $APIKey"
    }

    $parameters = @{
        'page[size]' = $PageSize
    }

    $APIParams = @{
        Uri = $uri
        Headers = $headers
        Body = $parameters
    }

    $tags = Invoke-RestMethod @APIParams

    return $tags
}