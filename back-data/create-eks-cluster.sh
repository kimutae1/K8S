export cluster=alb2
export AWS_DEFAULT_REGION=ap-northeast-2
export subnets="subnet-0f0036f4015024a5b,subnet-078f130fd97bc382e"
export role=arn:aws:iam::911781391110:role/devops-role



echo $cluster
echo $AWS_DEFAULT_REGION
echo $subnets
echo $role

eksctl create cluster --name $cluster --vpc-private-subnets $subnets --without-nodegroup --fargate  --authenticator-role-arn  $role


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