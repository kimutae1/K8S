#!/bin/bash
#export env="dev" # Environment
#if [ "$env" = "dev" ]; then export cluster_env=develop; elif [ "$env" = "stg" ]; then export cluster_env=release; elif [ "$env" = "prd" ]; then export cluster_env=main; fi # Cluster ENV

account_id=$(aws sts get-caller-identity | jq -r '.Account')

if [ "$account_id" = "391110" ]; then
 export env="dev"
 export cluster_env="develop"
elif [ "$account_id" = "203419" ]; then
  export env="stg"
  export cluster_env="release"
elif [ "$account_id" = "49841" ]; then
  export env="rnd"
  export cluster_env="develop"
elif [ "$account_id" = "3289" ]; then
  export env="prd"
  export cluster_env="main"
else
  # 알 수 없는 account_id인 경우에 대한 처리
  echo "You need AWS Login"
  exit 1
fi

export K8S_HOME=$(pwd)
export YAML_HOME=$K8S_HOME/03.service_yaml
export service_name="service"
# export service_name="managed"
#export service_name="gndchain"
#export service_name="hector"

if [ "$env" != "prd" ]; then export az_code=an2; else export az_code=as1 ; fi # Available Zone Code
export cluster_name=${env}-dorian-${service_name} # Cluster Name
export service_zone=dorian # Service Zone
export dns_a=argo # A record

# eks-role = cluster create / node-add
export eks_node_role=$(aws iam get-role --role-name EKS-Node-Role | jq -r '.Role.Arn') # export Cluster, Node Role
export eks_sa_role=$(aws iam get-role --role-name EKS-SA-Role | jq -r '.Role.Arn') # export SA Role
export devops_role=$(aws iam get-role --role-name devops-role | jq -r '.Role.Arn') # export devops_role
export sso_role=$(aws iam list-roles --query 'Roles[?contains(RoleName, `AWSReservedSSO_Develop_DevOps`)]' | jq -r '.[0].Arn' | sed 's/\/aws-reserved\/sso\.amazonaws\.com//') # export sso_role
export region_code=$(aws configure list |grep region |awk '{print $2}') # Region Code
export vpc_name=$(aws ec2 describe-vpcs  | jq -r '.Vpcs[].Tags[].Value' | grep ${service_zone}) ; # VPC Name
export domain=dorian.io # domain
if [ "$env" != "prd" ]; then export dns_zone=${env}.${domain}; else export dns_zone=${domain}; fi # dns_zone
if [ "$env" != "prd" ]; then export dns_list=(${env}.dorian.io, ${env}.in.dorian.io ); else export dns_list=(dorian.io, in.dorian.io ); fi # dns_list

export sub_domain=${service_name}-
export full_domain=${dns_a}.${dns_zone} # Full Domain

# Cluster Info
export clusters=(service)
for clusters_name in ${clusters[@]};
  do
    export ${clusters_name}_cluster_endpoint=$(aws eks describe-cluster --name ${env}-${service_zone}-${clusters_name} | jq -r '.cluster.endpoint');
    export ${clusters_name}_cluster_oidc=$(aws eks describe-cluster --name ${env}-${service_zone}-${clusters_name} | jq -r '.cluster.identity.oidc.issuer');
    export ${clusters_name}_cluster_ca=$(aws eks describe-cluster --name ${env}-${service_zone}-${clusters_name} | jq -r '.cluster.certificateAuthority.data');
  done

# CidrBlock, VpcId
export $(aws ec2 describe-vpcs --filters Name=tag:Name,Values=${vpc_name} | \
jq -r '.Vpcs[]|{CidrBlock, VpcId}|to_entries|.[]|[.key, .value]|join("=")')

# UserId, Account, RoleArn
export $(aws sts get-caller-identity |jq  -r '.|to_entries|.[]|[.key, .value]|join("=")')

# SubnetId
export `aws ec2 describe-subnets --filters "Name=tag:Name,Values=*sbn-${env}-${az_code}-${service_zone}*" | \
jq -r '.Subnets[] | {SubnetId: .SubnetId, Name: (.Tags[] | select(.Key=="Name" and (.Value | contains("data") | not) \
and (.Value | contains("ecs") | not )).Value | gsub("-"; "_"))} | [.Name, .SubnetId] | join("=")' | cut -d "_" -f 5,6`

# Certificate ARN
export cert_arn=$(aws acm list-certificates | jq -r ".CertificateSummaryList[] | select(.DomainName | contains(\"*.$dns_zone\")) | .CertificateArn")

echo env="$env" # Environment
echo cluster_name=$cluster_name
echo full_domain=$full_domain
