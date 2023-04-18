export cluster=alb4
export AWS_DEFAULT_REGION=ap-northeast-2
export region=ap-northeast-2
#export subnets="subnet-0f0036f4015024a5b,subnet-078f130fd97bc382e"
export pri_pub=private
export pri_subnet_a_id="subnet-0bc60172da6da0e5e"
export pri_subnet_c_id="subnet-0d3309db6f0ad0260"
#export pri-subnet-a-cidr="subnet-0bc60172da6da0e5e"
#export pri-subnet-c-cidr="subnet-0bc60172da6da0e5e"
export role=arn:aws:iam::911781391110:role/devops-role
#dev
export vpcid="vpc-09a6049b96e74bf58"
export vpccidr="10.10.0.0/16"

echo $cluster ; echo $role

#rm -rf eks-fargate.yaml
cat <<EOF > eks-fargate.yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
 name: ${cluster}
 region: ${region}

vpc:
  id: ${vpcid}
  cidr: ${vpccidr}
  subnets:
    private:
      ${region}a:
         id: ${pri_subnet_a_id}
      ${region}c:
         id: ${pri_subnet_c_id}

fargateProfiles:
  - name: fp-default
    selectors:
      - namespace: default
      - namespace: kube-system
    subnets:
      - ${pri_subnet_a_id}
      - ${pri_subnet_c_id}

iam:
  serviceRoleARN: $role

EOF

cat eks-fargate.yaml

eksctl create cluster -f eks-fargate.yaml  
#eksctl create cluster -f eks-fargate.yaml  --fargate
#eksctl create cluster -f eks-fargate.yaml --name $cluster --vpc-private-subnets $subnets


#aws eks create-cluster \
#--name $cluster  \
#--kubernetes-version 1.25 \
#--role-arn  $role \ 
#--resources-vpc-config subnetIds=$subnets \
#--role-arn arn:aws:iam::111122223333:role/eks-service-role-AWSServiceRoleForAmazonEKS-EXAMPLEBKZRQR 
#--resources-vpc-config subnetIds=subnet-a9189fe2,subnet-50432629
#eksctl --profile dev create cluster --name $cluster --vpc-private-subnets $subnets --without-nodegroup --falgate

#--region ap-northeast-2  

#eksctl create iamserviceaccount --name my-service-account --namespace default --cluster my-cluster --role-name "my-role" \
#    --attach-policy-arn arn:aws:iam::111122223333:policy/my-policy --approve