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

##Kraken-Domain
CD C:\dev\Kraken-Domain
mvn clean install
if (-not $?)
{
    Write-Failure "Kraken-Domain" "mvn clean install"
    exit 1
}
mvn deploy:deploy-file "-Durl=file:///C:\dev\Repo" "-Dfile=C:\dev\Kraken-Domain\target\domain-1.0-SNAPSHOT.jar" "-DgroupId=lambethd.kraken" "-DartifactId=domain" "-Dpackaging=jar" "-Dversion=1.0"
if (-not $?)
{
    Write-Failure "Kraken-Domain" "deploy package"
    exit 1
}

##Kraken-Repository
cd C:\dev\Kraken-Repository
mvn clean install
if (-not $?)
{
    Write-Failure "Kraken-Repository" "mvn clean install"
    exit 1
}
mvn deploy:deploy-file "-Durl=file:///C:\dev\Repo" "-Dfile=C:\dev\Kraken-Repository\target\repository-1.0-SNAPSHOT.jar" "-DgroupId=lambethd.kraken" "-DartifactId=repository" "-Dpackaging=jar" "-Dversion=1.0"
if (-not $?)
{
    Write-Failure "Kraken-Repository" "deploy package"
    exit 1
}


##Kraken-Resources
cd C:\dev\Kraken-Resources
if (-not $?)
{
    Write-Failure "Kraken-Resources" "mvn clean install"
    exit 1
}
mvn clean install
mvn deploy:deploy-file "-Durl=file:///C:\dev\Repo" "-Dfile=C:\dev\Kraken-Resources\target\resources-1.0-SNAPSHOT.jar" "-DgroupId=lambethd.kraken" "-DartifactId=resources" "-Dpackaging=jar" "-Dversion=1.0"
if (-not $?)
{
    Write-Failure "Kraken-Resources" "deploy package"
    exit 1
}


##Kraken-Data-Services
cd C:\dev\Kraken-Data-Services
mvn clean install
if (-not $?)
{
    Write-Failure "Kraken-Data-Services" "mvn clean install"
    exit 1
}
pscp -i C:\dev\kraken-key-pair-aws.ppk C:\dev\Kraken-Data-Services\target\kraken-data-services-0.1.0.jar ec2-user@3.21.13.234:/var/kraken/
if (-not $?)
{
    Write-Failure "Kraken-Data-Services" "deploy to server"
    exit 1
}


Write-Success