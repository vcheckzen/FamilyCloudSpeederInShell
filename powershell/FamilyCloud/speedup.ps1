function GetSignature {
    Param (
        $data,
        $key
    )
    $hmacsha = New-Object System.Security.Cryptography.HMACSHA1
    $hmacsha.key = [Text.Encoding]::ASCII.GetBytes($key)
    $signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($data))
    return [System.BitConverter]::ToString($signature).Replace('-', '').ToUpper()
}

function GetFormatedDate {
    Param (
        $formatString
    )
    return [DateTime]::UtcNow.ToString($formatString)
}

function Login {
    param (
        $accessToken,
        $appKey
    )
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('AppKey', $appKey)
    $response = Invoke-WebRequest -Uri "${HOSTNAME}${LOGIN_URL}?accessToken=${accessToken}" -Headers $headers
    return $response.Content
}

function SpeedUp {
    param (
        $qosClientSn,
        $sessionKey,
        $signature,
        $date,
        $prodCode
    )    
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('SessionKey', $sessionKey)
    $headers.Add('Signature', $signature)
    $headers.Add('Date', $date)
    $postParams = @{prodCode = $prodCode }
    try {
        Invoke-WebRequest -Uri "${HOSTNAME}${ACCESS_URL}?qosClientSn=${qosClientSn}" -Headers $headers -Method POST -Body $postParams
    }
    catch {
        $sesponseStream = $_.Exception.Response.GetResponseStream()
        $streamReader = New-Object System.IO.StreamReader($sesponseStream)
        $responseBody = $streamReader.ReadToEnd();
    }
    return $responseBody
}

$HOSTNAME = 'http://api.cloud.189.cn'
$LOGIN_URL = '/login4MergedClient.action'
$ACCESS_URL = '/family/qos/startQos.action'
$BASE_DIRECTORY = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
[System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions") 2>&1 | Out-Null
$SERIALIZAR = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$CONFIG = $SERIALIZAR.DeserializeObject((Get-Content -Path $BASE_DIRECTORY\config.json))

"*******************************************"
$COUNT = 0
while (1) {
    $COUNT = $COUNT + 1
    "Sending HeartBeat Package <${COUNT}>"
    [xml]$loginResult = Login $CONFIG.accessToken $CONFIG.AppKey
    $sessionKey = $loginResult.userSession.familySessionKey
    $sessionSecret = $loginResult.userSession.familySessionSecret

    $method = $CONFIG.setting.method
    $formatedDate = GetFormatedDate 'R'
    $data = "SessionKey=${sessionKey}&Operate=${method}&RequestURI=${ACCESS_URL}&Date=${formatedDate}"
    $signature = GetSignature $data $sessionSecret

    "HeartBeat:<Signature:${signature}>"
    "Date:<${formatedDate}>"
    $result = SpeedUp (New-Guid) $sessionKey $signature $formatedDate $CONFIG.sendData.prodCode
    "Response:$result"
    $msg = 'Failed'
    if (([xml]$result).error.message.contains('open')) {
        $msg = 'Succeeded'
    }
    "Sending HeartBeat Package <${COUNT}> $msg."
    "*******************************************"
    Start-Sleep -Seconds $CONFIG.setting.rate
}
