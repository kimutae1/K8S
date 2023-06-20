#!/bin/bash
 # Set the cluster name.
CLUSTER_NAME="alb7"
 # Set the namespace for the managed node group.
NAMESPACE="managed"
 # Set the organization name for the certificate.
ORG_NAME="kstadium.io"
 # Create a private key.
openssl genrsa -out eks.key 2048
 # Create a certificate signing request (CSR).
cat << EOF > eks.csr.conf
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
 [dn]
CN = $CLUSTER_NAME
O = $ORG_NAME
EOF
 openssl req -new -key eks.key -out eks.csr -config eks.csr.conf
 # Create a Kubernetes secret for the CSR.
kubectl create secret tls eks-csr --key eks.key --cert eks.csr -n $NAMESPACE
 # Create a CSR object.
cat << EOF > eks-csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: eks-csr
spec:
  request: $(cat eks.csr | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  signerName: eks.amazonaws.com
EOF
 # Apply the CSR object.
kubectl apply -f eks-csr.yaml -n $NAMESPACE
 # Approve the CSR.
kubectl certificate approve eks-csr -n $NAMESPACE
 # Get the signed certificate.
kubectl get csr eks-csr -o jsonpath='{.status.certificate}' | base64 --decode > eks.crt
 # Create a Kubernetes secret for the signed certificate and private key.
kubectl create secret tls eks-tls --key eks.key --cert eks.crt -n $NAMESPACE
 # Deploy the EKS worker nodes.
cat << EOF > eks-worker-nodes.yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: $CLUSTER_NAME
  region: us-west-2
nodeGroups:
  - name: ng-1
    instanceType: t2.small
    desiredCapacity: 2
    ssh:
      publicKeyName: my-ssh-key
    iam:
      withAddonPolicies:
        autoScaler: true
        albIngress: true
    volumeSize: 20
    labels:
      nodegroup-type: ng-1
    tags:
      nodegroup-type: ng-1
EOF
 eksctl create nodegroup -f eks-worker-nodes.yaml


 #위 스크립트를 실행하면, EKS 클러스터를 위한 인증서와 CSR이 생성되고
#,노드 배포까지 자동으로 이루어집니다. 
#이때,  CLUSTER_NAME  변수를 자신의 EKS 클러스터 이름으로 변경해야 합니다.
# 또한,  NAMESPACE  변수는 자신의 노드 그룹의 네임스페이스로 변경해야 합니다. 
#마지막으로,  ORG_NAME  변수는 인증서에 사용될 조직 이름으로 변경해야 합니다.