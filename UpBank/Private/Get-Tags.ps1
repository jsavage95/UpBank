Function Get-Tags{
    [CmdletBinding()]
    param (
        [Parameter()]
        [System.String]
        $APIKey = (Get-APIKey),
        [System.String]
        $PageSize = '2'
    )

    $headers = @{
        'Authorization' = "Bearer $APIKey"
    }

    $uri = 'https://api.up.com.au/api/v1/tags'

    $parameters = @{
        'page[size]' = $PageSize
    }

    $tags = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -Body $parameters

    return $tags
}