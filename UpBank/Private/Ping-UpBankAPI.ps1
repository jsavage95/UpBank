<#
.SYNOPSIS
Pings the Up Bank API to check its availability.

.DESCRIPTION
The `Ping-UpBankAPI` function sends a request to the Up Bank API's ping endpoint. This can be used to verify whether the API is accessible and if the provided API key is valid.

.PARAMETER APIKey
The API key required to authenticate with the Up Bank API. This can be passed as an argument or through the pipeline.

.PARAMETER Uri
The endpoint URL for the Up Bank API ping service. The default value is 'https://api.up.com.au/api/v1/util/ping', but can be overridden if necessary.

.EXAMPLE
Ping-UpBankAPI -APIKey "YourAPIKeyHere"

This example sends a request to the default Up Bank API's ping endpoint using the specified API key.

.EXAMPLE
"YourAPIKeyHere" | Ping-UpBankAPI

This example demonstrates how to send a request by piping the API key into the function.

.NOTES
Ensure that the API key is kept confidential and is not exposed in logs or to unauthorized individuals.
#>

Function Ping-UpBankAPI{
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [System.String]
        $APIKey,
        
        [System.String]
        $Uri = 'https://api.up.com.au/api/v1/util/ping'
    )

    $headers = @{
        'Authorization' = "Bearer $APIKey"
    }

    $APIParams = @{
        Uri = $uri
        Headers = $headers
    }

    $response = Invoke-RestMethod @APIParams

    return $response
}
