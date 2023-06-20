#!/bin/bash
 # Set variables
export NODE_NAME=ip-10-10-16-93.ap-northeast-2.compute.internal
export NAMESPACE=managed
export SECRET_NAME=kstadium
 # Generate a CSR for the node
openssl req -new -keyout $NODE_NAME.key -out $NODE_NAME.csr -subj "/CN=$NODE_NAME.$NAMESPACE.svc"
 # Create a CSR object
cat <<EOF > $NODE_NAME.yaml 
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: $NODE_NAME-csr
spec:
  signerName: kubernetes.io/kube-apiserver-client
  groups:
  - system:authenticated
  request: $(cat $NODE_NAME.csr | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF



kubectl apply -f $NODE_NAME.yaml
 # Approve the CSR
kubectl certificate approve $NODE_NAME-csr
 # Get the signed certificate
kubectl get csr $NODE_NAME-csr -o jsonpath='{.status.certificate}' | base64 --decode > $NODE_NAME.crt
 # Create a Kubernetes secret containing the certificate and key
kubectl create secret tls $SECRET_NAME --cert=$NODE_NAME.crt --key=$NODE_NAME.key -n $NAMESPACE
 # Label the node to use the secret
kubectl label node $NODE_NAME $SECRET_NAME=enabled