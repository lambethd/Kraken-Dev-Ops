function Write-Success {
    Write-Host "`n`n"
    Write-Host "####################################"
    Write-Host "#############Success!###############"
    Write-Host "####################################"
}
function Write-Failure {
    param(
        $Stage,
        $Type
    )
    Write-Host "`n`n"
    Write-Host "####################################"
    Write-Host "##############Failed!###############"
    Write-Host "####################################"
    Write-Host "Failed during $Stage $Type"
}

C:\dev\DeployServer.ps1
if (-not $?)
{
    Write-Failure "Server" "deploy"
    exit 1
}
C:\dev\DeployDataServices.ps1
if (-not $?)
{
    Write-Failure "DataServices" "deploy"
    exit 1
}
C:\dev\DeployUI.ps1
if (-not $?)
{
    Write-Failure "UI" "deploy"
    exit 1
}

Write-Success