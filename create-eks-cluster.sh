export cluster=SsoCreated

export AWS_DEFAULT_REGION=ap-northeast-2
export subnets="subnet-0f0036f4015024a5b,subnet-078f130fd97bc382e"
eksctl create cluster --name $cluster --vpc-private-subnets $subnets --without-nodegroup --fargate
#eksctl --profile dev create cluster --name $cluster --vpc-private-subnets $subnets --without-nodegroup --falgate

#--region ap-northeast-2  

#eksctl create iamserviceaccount --name my-service-account --namespace default --cluster my-cluster --role-name "my-role" \
#    --attach-policy-arn arn:aws:iam::111122223333:policy/my-policy --approve