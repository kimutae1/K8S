cat << EOF > auto-csr.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: auto-approve-csrs
rules:
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - approve
EOF


kubectl apply -f auto-csr.yaml -n managed