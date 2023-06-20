#1. Create a private key:
openssl genrsa -out eks.key 2048
#2. Create a certificate signing request (CSR):
openssl req -new -key eks.key -out eks.csr -subj "/CN=eks-cluster/O=Amazon"
#3. Create a Kubernetes secret for the CSR:
kubectl create secret tls eks-csr --key eks.key --cert eks.csr
#4. Approve the CSR on the Kubernetes cluster:
kubectl certificate approve eks-csr
#5. Download the signed certificate:
kubectl get csr eks-csr -o jsonpath='{.status.certificate}' | base64 --decode > eks.crt
#Once the above steps are completed, you should have a signed certificate file named  eks.crt  that can be used for EKS.