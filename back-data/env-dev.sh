#export cluster=eks-gndchain
#export AWS_DEFAULT_REGION=ap-northeast-2
#export subnets="subnet-0f0036f4015024a5b,subnet-078f130fd97bc382e"
#export role=arn:aws:iam::911781391110:role/eks-role

cluster=eks-gndchain
AWS_DEFAULT_REGION=ap-northeast-2
subnets="subnet-0f0036f4015024a5b,subnet-078f130fd97bc382e"
role=arn:aws:iam::911781391110:role/eks-role

echo $cluster
echo $AWS_DEFAULT_REGION
echo $subnets
echo $role
