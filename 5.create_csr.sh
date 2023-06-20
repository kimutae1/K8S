openssl genrsa -out myserver.key 2048

openssl req -new -key myserver.key -out myserver.csr -subj "/CN=myserver.default.svc"

base_64=$(cat myserver.csr | base64 -w 0 | tr -d "\n")

cat >mycsr.yaml <<EOF
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myserver
spec:
  request: $base_64
  signerName: beta.eks.amazonaws.com/app-serving
  usages:
    - digital signature
    - key encipherment
    - server auth
EOF


kubectl apply -f mycsr.yaml


kubectl certificate approve myserver

