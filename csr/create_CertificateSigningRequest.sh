cat <<EOF > csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ${CSR_NAME}
spec:
  groups:
  - system:authenticated
  request: $(cat ./server.csr | base64 | tr -d '\r\n')
  signerName: beta.eks.amazonaws.com/app-serving
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF


 kubectl create -f csr.yaml
#certificatesigningrequest.certificates.k8s.io/vault-csr created
#
#$ kubectl certificate approve ${CSR_NAME}
#certificatesigningrequest.certificates.k8s.io/vault-csr approved
#
#$ kubectl get csr ${CSR_NAME}
#NAME        AGE   SIGNERNAME                           REQUESTOR          REQUESTEDDURATION   CONDITION
#vault-csr   0s    beta.eks.amazonaws.com/app-serving   kubernetes-admin   <none>              Approved,Issued
#
#$ kubectl get secret vault-server-tls -o jsonpath='{.data.vault\.crt}' --namespace=vault-namespace | base64 -d
#-----BEGIN CERTIFICATE-----
#MIIEEDCCAvigAwIBAgIUBMayz5vzpUL0LHhGyv/0LzdzEKEwDQYJKoZIhvcNAQEL
#...
#WpEPdQITdq6DY7ZumGBWWOoRhKNr75o8YRNiFjLopDvdh/Nu
#-----END CERTIFICATE-----