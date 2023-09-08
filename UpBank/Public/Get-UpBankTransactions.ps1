Function Get-UpBankTransactions {
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
        $Uri = 'https://api.up.com.au/api/v1/transactions',
        [Parameter()]
        [System.String]
        $PageSize = '20',
        [Parameter()]
        [System.String]
        $FilterTag,
        [Parameter()]
        [ValidateSet('HELD', 'SETTLED')]
        [System.String]
        $FilterStatus = 'SETTLED',
        [Parameter()]
        [System.String]
        $FilterSince,
        [Parameter()]
        [System.String]
        $FilterUntil,
        [Parameter()]
        [System.String]
        $FilterCategory
    )

    $headers = @{
        'Authorization' = "Bearer $APIKey"
    }

    $parameters = @{
        'page[size]'     = $PageSize
        'filter[status]' = $FilterStatus
    }

    $filters = @{
        'filter[tag]'      = $FilterTag
        'filter[since]'    = $FilterSince
        'filter[until]'    = $FilterUntil
        'filter[category]' = $FilterCategory
    }

    $filters.GetEnumerator() | Where-Object { $_.Value } | ForEach-Object { $parameters[$_.Key] = $_.Value }

    $APIParams = @{
        Uri = $Uri
        Headers = $headers
        Body = $parameters
    }

    $response = Invoke-RestMethod @APIParams

    return $response
}
