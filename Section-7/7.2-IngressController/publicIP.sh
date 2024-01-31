#1.Show the Node Resource Group.
az aks show --resource-group aks-rg --name akstraining --query nodeResourceGroup -o tsv

#2.create an Azure Static IP
az network public-ip create --resource-group MC_aks-rg_akstraining_eastus --name IngressPublicIP --sku Standard --allocation-method static --query publicIp.ipAddress -o tsv

#3.Namespace creation in kubernetes
kubectl create namespace ingress-basic

#4.Add the Nginx Ingress Controller manifest files from the Helm
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

#5.Helm command to deploy the Ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.service.externalTrafficPolicy=Local \
    --set controller.service.loadBalancerIP="172.178.53.224"

#6.See the resources in ingress-basic namespace
kubectl get all -n ingress-basic

#7. Access the Public IP