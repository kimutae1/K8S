 #!/bin/bash
export vpc="kstadium"
export cluster_name=alb7

export region_code=$(aws configure list |grep region |awk '{print $2}')

export vpc_name=$(aws ec2 describe-vpcs  | jq -r '.Vpcs[].Tags[].Value' | grep ${vpc}) ;
export $(aws ec2 describe-vpcs --filters Name=tag:Name,Values=${vpc_name} | \
 jq -r '.Vpcs[]|{CidrBlock, VpcId}|to_entries|.[]|[.key, .value]|join("=")' |paste -sd " ")
#아래 두개는 위에 스크립트로 대체됨
#export vpccidr="10.10.0.0/16"
#export vpc_ID=$(aws ec2 describe-vpcs --filters Name=tag:Name,Values=${vpc_name} | jq -r '.Vpcs[].VpcId')

export $(aws sts get-caller-identity |jq  -r '.|to_entries|.[]|[.key, .value]|join("=")' |paste -sd " ")
#subnet의 값을 aws-cli로 가져와서 변수에 저장,jq 활용 code 이다
#aws ec2 descrebe-subnets --filter Name=vpc-id,Values=$vpc_ID | jq -r '.Subnets[]|.SubnetId+" "+.CidrBlock+" "+(.Tags[]|select(.Key=="Name").Value)'
#이 중 kstadium이 포함된 subnet만 특정 하고 싶다면

#ksta 문자열이 포함된 내역 중 .Tags만 가져오기
#aws ec2 describe-subnets --filter Name=vpc-id,Values=$VpcId | jq -r '.Subnets|.[]| select(.Tags[]|.Value | contains("ksta"))|.Tags'


#export pri_pub=private
export pub_subnet_a_id="subnet-0515674ed4dc1772a"
export pub_subnet_c_id="subnet-0b89688a3a1ff4a93"
export pri_subnet_a_id="subnet-0bc60172da6da0e5e"
export pri_subnet_c_id="subnet-0d3309db6f0ad0260"
export role=arn:aws:iam::911781391110:role/devops-role

#ARN / Account / UserId

#cat <<EOF > export.sh
#export cluster_name=$cluster_name
#export region_code=ap-northeast-2
##ARN / Account / UserId
#export $(aws sts get-caller-identity |jq  -r '.|to_entries|.[]|[.key, .value]|join("=")' |paste -sd " ")
#export vpc_name=$(aws ec2 describe-vpcs  | jq -r '.Vpcs[].Tags[].Value' | grep ${vpc}) ;
#sleep 2
#export vpc_ID=$(aws ec2 describe-vpcs --filters Name=tag:Name,Values=${vpc_name} | jq -r '.Vpcs[].VpcId')
#EOF

#env |grep AWS
#sleep 1 ;
#chmod 755 $PWD/export.sh
#source ${PWD}/export.sh


##Subnet ID, CIDR, Subnet Name export
#aws ec2 describe-subnets --filter Name=vpc-id,Values=$vpc_ID | jq -r '.Subnets[]|.SubnetId+" "+.CidrBlock+" "+(.Tags[]|select(.Key=="Name").Value)'
#echo $vpc_ID > vpc_subnet.txt
#aws ec2 describe-subnets --filter Name=vpc-id,Values=$vpc_ID | jq -r '.Subnets[]|.SubnetId+" "+.CidrBlock+" "+(.Tags[]|select(.Key=="Name").Value)' >> vpc_subnet.txt
#cat vpc_subnet.txt
#
## VPC, Subnet ID 환경변수 저장 
#export PublicSubnet01=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=eksworkshop-PublicSubnet01' | jq -r '.Subnets[].SubnetId')
#export PublicSubnet02=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=eksworkshop-PublicSubnet02' | jq -r '.Subnets[].SubnetId')
#export PublicSubnet03=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=eksworkshop-PublicSubnet03' | jq -r '.Subnets[].SubnetId')
#export PrivateSubnet01=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=eksworkshop-PrivateSubnet01' | jq -r '.Subnets[].SubnetId')
#export PrivateSubnet02=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=eksworkshop-PrivateSubnet02' | jq -r '.Subnets[].SubnetId')
#export PrivateSubnet03=$(aws ec2 describe-subnets --filters 'Name=tag:Name,Values=eksworkshop-PrivateSubnet03' | jq -r '.Subnets[].SubnetId')
#echo "export vpc_ID=${vpc_ID}" | tee -a ~/.bash_profile
#echo "export PublicSubnet01=${PublicSubnet01}" | tee -a ~/.bash_profile
#echo "export PublicSubnet02=${PublicSubnet02}" | tee -a ~/.bash_profile
#echo "export PublicSubnet03=${PublicSubnet03}" | tee -a ~/.bash_profile
#echo "export PrivateSubnet01=${PrivateSubnet01}" | tee -a ~/.bash_profile
#echo "export PrivateSubnet02=${PrivateSubnet02}" | tee -a ~/.bash_profile
#echo "export PrivateSubnet03=${PrivateSubnet03}" | tee -a ~/.bash_profile
#
## eks cluster 환경변수 생성 
#export ekscluster_name="eksworkshop"
#export eks_version="1.22"
#export instance_type="m5.xlarge"
#export public_selfmgmd_node="frontend-workloads"
#export private_selfmgmd_node="backend-workloads"
#export public_mgmd_node="managed-frontend-workloads"
#export private_mgmd_node="managed-backend-workloads"
#export publicKeyPath="/home/ec2-user/environment/eksworkshop.pub"
#
#echo ${ekscluster_name}
#echo ${AWS_REGION}
#echo ${eks_version}
#echo ${PublicSubnet01}
#echo ${PublicSubnet02}
#echo ${PublicSubnet03}
#echo ${PrivateSubnet01}
#echo ${PrivateSubnet02}
#echo ${PrivateSubnet03}
#echo ${MASTER_ARN}
#echo ${instance_type}
#echo ${public_selfmgmd_node}
#echo ${private_selfmgmd_node}
#echo ${public_mgmd_node}
#echo ${private_mgmd_node}
#echo ${publicKeyPath}
#
## ekscluster name, version, instance type, nodegroup label 환경변수 저장.  
#echo "export ekscluster_name=${ekscluster_name}" | tee -a ~/.bash_profile
#echo "export eks_version=${eks_version}" | tee -a ~/.bash_profile
#echo "export instance_type=${instance_type}" | tee -a ~/.bash_profile
#echo "export public_selfmgmd_node=${public_selfmgmd_node}" | tee -a ~/.bash_profile
#echo "export private_selfmgmd_node=${private_selfmgmd_node}" | tee -a ~/.bash_profile
#echo "export public_mgmd_node=${public_mgmd_node}" | tee -a ~/.bash_profile
#echo "export private_mgmd_node=${private_mgmd_node}" | tee -a ~/.bash_profile
#echo "export publicKeyPath=${publicKeyPath}" | tee -a ~/.bash_profile
#
#source ~/.bash_profile
#
#