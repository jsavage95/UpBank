Function Get-UpBankTransactions {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [System.String]
        $APIKey,
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

    $uri = 'https://api.up.com.au/api/v1/transactions'

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

    $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -Body $parameters

    return $response
}
