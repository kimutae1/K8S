helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install nginx-kic nginx-stable/nginx-ingress --namespace nginx-ingress  --set controller.enableCustomResources=true --set controller.enableCertManager=true


helm repo add jetstack https://charts.jetstack.io
helm repo update


helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager --create-namespace \
  --version v1.9.1  --set installCRDs=true

#NGINX Cafe 예제를 사용하여 backend 배포 및 서비스를 제공할 예정입니다. 이것은 NGINX가 제공한 문서에서 사용되는 일반적인 예입니다.
#1. NGINX Ingress Github 클론(Clone)
  git clone https://github.com/nginxinc/kubernetes-ingress.git


cat << EOF >  issure.yaml
  apiVersion: cert-manager.io/v1
  kind: ClusterIssuer
  metadata:
    name: prod-issuer
  spec:
    acme:
      email: example@example.com
      server: https://acme-v02.api.letsencrypt.org/directory
      privateKeySecretRef:
        name: prod-issuer-account-key
      solvers:
      - http01:
         ingress:
           class: nginx
EOF


