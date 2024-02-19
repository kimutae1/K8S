cat << EOF > rbac.yaml 
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: node-csr-create
rules:
- apiGroups: ["certificates.k8s.io"]
  resources: ["certificatesigningrequests"]
  verbs: ["create"]

EOF

cat << EOF > role_bind.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: node-csr-create-binding
subjects:
- kind: User
  name: system:node:<node-name>
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: node-csr-create
  apiGroup: rbac.authorization.k8s.io
EOF


kubectl auth can-i create certificatesigningrequests \
  --namespace kube-system \
  --as system:node:{{EC2PrivateDNSName}}
  #--as system:node:<node-name>