export CERTMGR_VERSION=1.9.1
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v${CERTMGR_VERSION}/cert-manager.yaml
kubectl -n cert-manager get pods
