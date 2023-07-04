#!/bin/bash
# Environment
export env="dev"
# Available Zone Code
export az_code="an2"
# Service_zone
export service_zone="kstadium"
# Cluster Name
export cluster_name=dev-kstadium-gndchain
# eks-role = cluster create / node-add
export eks_role=$(aws iam get-role --role-name eksFullAccessRole | jq -r '.Role.Arn')
#export node_role=devops-role
export devops_role=$(aws iam get-role --role-name devops-role | jq -r '.Role.Arn')
# sso-role = ConfigMap
export sso_role=$(aws iam list-roles --query 'Roles[?contains(RoleName, `AWSReservedSSO_crypted_devops`)]' | jq -r '.[0].Arn' | sed 's/\aws-reserved\/sso\.amazonaws\.com\///')

# Region Code
export region_code=$(aws configure list |grep region |awk '{print $2}')
# VPC Name
export vpc_name=$(aws ec2 describe-vpcs  | jq -r '.Vpcs[].Tags[].Value' | grep ${service_zone}) ;

# CidrBlock, VpcId
export $(aws ec2 describe-vpcs --filters Name=tag:Name,Values=${vpc_name} | \
jq -r '.Vpcs[]|{CidrBlock, VpcId}|to_entries|.[]|[.key, .value]|join("=")')

# UserId, Account, RoleArn
export $(aws sts get-caller-identity |jq  -r '.|to_entries|.[]|[.key, .value]|join("=")')

# SubnetId
export `aws ec2 describe-subnets --filters "Name=tag:Name,Values=*sbn-${env}-${az_code}-${service_zone}*" | \
jq -r '.Subnets[] | {SubnetId: .SubnetId, Name: (.Tags[] | select(.Key=="Name" and (.Value | contains("data") | not) \
and (.Value | contains("ecs") | not )).Value | gsub("-"; "_"))} | [.Name, .SubnetId] | join("=")' | cut -d "_" -f 5,6`

