# Create a CSR object
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: node-csr
spec:
  groups:
  - system:authenticated
  request: $(cat node.csr | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF
 # Approve the CSR
kubectl certificate approve node-csr
 # Get the signed certificate
kubectl get csr node-csr -o jsonpath='{.status.certificate}' | base64 --decode > node.crt
 # Create a Kubernetes secret containing the certificate and key
kubectl create secret tls node-tls --cert=node.crt --key=node.key
 # Label the node to use the secret
kubectl label node <node-name> node-tls=enabled