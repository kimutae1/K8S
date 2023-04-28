#!/bin/bash
# EKS 클러스터 이름
# AWS 계정 ID

# 보안 그룹 ID 가져오기
#security_group_id=$(aws eks describe-cluster --name $cluster_name --query 'cluster.resourcesVpcConfig.clusterSecurityGroupId' --output text)

# configmap.yaml 파일 생성

#export ${Account}
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
       username: system:node:{{SessionName}}
       rolearn: arn:aws:iam::${Account}:role/devops-role

    - groups:
       - system:bootstrappers
       - system:nodes
       - system:node-proxier
       - system:masters
      username: system:node:{{SessionName}}
      rolearn: arn:aws:iam::911781391110:role/AWSReservedSSO_crypted_devops_1c74128b3bb9822e


EOF

kubectl apply -f configmap.yaml

  #mapUsers: |
  #  - rolearn: arn:aws:iam::911781391110:user/AWSReservedSSO_crypted_devops_1c74128b3bb9822e/dorian.kim@crypted.co.kr
  #  groups:
  #   - system:bootstrappers
  #   - system:nodes
  #   - system:node-proxier
  #   - system:masters
  #  username: system:node:{{SessionName}}

#       - arn:aws:iam::911781391110:role/devops-role/devops-session
#       - arn:aws:iam::911781391110:role/AWSReservedSSO_crypted_devops_1c74128b3bb9822e


#      -  rolearn: arn:aws:iam::911781391110:role/devops-role/devops-session
#           username: system:node:{{SessionName}}
#           groups:
#            - system:bootstrappers
#            - system:nodes
#            - system:node-proxier
#            - system:masters


#  mapUsers: |
#    groups:
#     - system:bootstrappers
#     - system:nodes
#     - system:node-proxier
#     - system:masters
#    rolearn: arn:aws:iam::911781391110:user/AWSReservedSSO_crypted_devops_1c74128b3bb9822e/dorian.kim@crypted.co.kr
#    username: system:node:{{SessionName}}

#    - groups:
#      - system:bootstrappers
#      - system:nodes
#      - system:node-proxier
#    -  rolearn: arn:aws:iam::911781391110:role/eksctl-albtest-cluster-FargatePodExecutionRole-1O3BD7W6N65L1
#    -  username: system:node:{{SessionName}}
#    
#    
#    
#  
#  