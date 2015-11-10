$root = 'http://it-hdjenkins:8080/api/json'
$user = "un"
$pass= "api"
$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($user, $secpasswd)

$result = Invoke-RestMethod $root -Headers @{"Authorization" = "Basic "+[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($User+":"+$pass ))}

$url='http://it-hdjenkins:8080/job/StatusBoard%20Generate/build?token=Token'
Invoke-WebRequest -Uri $url -Headers @{"Authorization" = "Basic "+[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($User+":"+$pass ))}
