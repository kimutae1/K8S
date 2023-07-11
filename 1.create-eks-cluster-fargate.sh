#!/bin/bash

# Fargate 기반 Cluster를 생성하는 YAML 파일 작성
cat <<EOF > eks-fargate.yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
 name: ${cluster_name}
 region: ${region_code}

iamIdentityMappings:
  # - arn: $eks_role
  #   groups:
  #     - system:masters
  #     - system:bootstrappers
  #     - system:nodes
  #   username: system:node:{{EC2PrivateDNSName}}
    # noDuplicateARNs: true # prevents shadowing of ARNs

  - arn: $sso_role
    groups:
      - system:masters
      - system:bootstrappers
      - system:node-proxier
      - system:nodes
    username: system:node:{{SessionName}}
    noDuplicateARNs: true # prevents shadowing of ARNs

  - arn: $devops_role
    groups:
      - system:masters
      - system:bootstrappers
      - system:node-proxier
      - system:nodes
    username: system:node:{{SessionName}}
    noDuplicateARNs: true # prevents shadowing of ARNs

vpc:
  id: ${VpcId}
  cidr: ${CidrBlock}
  subnets:
    private:
      `aws ec2 describe-subnets --subnet-ids $private_a |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${private_a}
      `aws ec2 describe-subnets --subnet-ids $private_c |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${private_c}
    public:
      `aws ec2 describe-subnets --subnet-ids $public_a |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${public_a}
      `aws ec2 describe-subnets --subnet-ids $public_c |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${public_c}

fargateProfiles:
  - name: fp-default
    podExecutionRoleARN: $eks_role
    selectors:
      - namespace: default
      - namespace: kube-system
    subnets:
      - ${private_a}
      - ${private_c}

iam:
  serviceRoleARN: $eks_role
EOF

cat eks-fargate.yaml

eksctl create cluster -f eks-fargate.yaml  