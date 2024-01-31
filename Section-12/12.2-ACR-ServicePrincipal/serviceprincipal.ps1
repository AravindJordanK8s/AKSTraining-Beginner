$ACR_NAME = "acrtraininghexa"
$SERVICE_PRINCIPAL_NAME = "service-principal-acr"

$ACR_REGISTRY_ID = az acr show --name $ACR_NAME --query id --output tsv
$SECRET = az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $ACR_REGISTRY_ID --role acrpull --query password --output tsv
$CLIENTID = az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query [].appId --output tsv

Write-Host "The Created Service principal ID: $CLIENTID"
Write-Host "The Created Service principal password: $SECRET"