#!/bin/bash

# ConfigMap 생성을 위한 YAML 파일 작성
cat <<EOF > configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles:  |
    -  groups:
        - system:bootstrappers
        - system:nodes
        - system:masters
       username: system:node:{{EC2PrivateDNSName}}
       rolearn: $eks_role
    - groups:
       - system:bootstrappers
       - system:nodes
       - system:node-proxier
       - system:masters
      username: system:node:{{SessionName}}
      rolearn: $sso_role
EOF

kubectl apply -f configmap.yaml

eksctl create iamidentitymapping --cluster ${cluster_name} --region=${region-code} \
    --arn arn:aws:iam::911781391110:role/eksFullAccessRole --username admin --group master \
    --no-duplicate-arns
