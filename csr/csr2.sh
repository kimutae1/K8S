apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ip-10-10-16-93-csr
spec:
  groups:
  - system:authenticated
  request: 
  signerName: beta.eks.amazonaws.com/app-serving
  usages:
  - digital signature
  - key encipherment
  - server auth
