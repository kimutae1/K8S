#!/bin/bash

cat << EOF > eks-csr.yaml 
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: eks-csr
spec:
  groups:
  - system:authenticated
  request: $(cat $NODE_NAME.csr | base64 | tr -d '\n')
  signerName: beta.eks.amazonaws.com/app-serving
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF

#!/bin/bash

# Get the current Kubernetes context.
export KUBECONFIG=$HOME/.kube/config

# Create the EKS CSR.
kubectl create -f eks-csr.yaml -n managed

# Apply the EKS CSR to all nodes.
kubectl apply -f eks-csr.yaml -n managed
