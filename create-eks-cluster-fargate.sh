echo $cluster_name ; echo $role

#rm -rf eks-fargate.yaml
cat <<EOF > eks-fargate.yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
 name: ${cluster_name}
 region: ${region_code}

vpc:
  id: ${vpc_ID}
  cidr: ${vpccidr}
  subnets:
    private:
      ${region}a:
         id: ${pri_subnet_a_id}
      ${region}c:
         id: ${pri_subnet_c_id}
    public:
      ${region}a:
         id: ${pub_subnet_a_id}
      ${region}c:
         id: ${pub_subnet_c_id}

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