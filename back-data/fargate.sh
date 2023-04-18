export AWS_PROFILE=dev
export cluster=alb-demo
export AWS_REGION=ap-northeast-2
export exrole=arn:aws:iam::911781391110:role/devops-role
export subnets="subnet-0f0036f4015024a5b subnet-078f130fd97bc382e"

#보안그룹확인
#aws eks describe-cluster --name $cluster --query cluster.resourcesVpcConfig.clusterSecurityGroupId

#eksctl create fargateprofile \
#    --cluster $cluster \
#    --name my-fargate-profile \
#    --namespace my-kubernetes-namespace \
#    --labels key=value


#aws eks create-fargate-profile \
#    --fargate-profile-name coredns \
#    --cluster-name $cluster \
#    --pod-execution-role-arn  $exrole \
#    --selectors namespace=kube-system,labels={k8s-app=kube-dns} \
#    --subnets $subnets

#다음 명령을 실행하여 CoreDNS pods에서 eks.amazonaws.com/compute-type : ec2 주석을 제거합니다.
#kubectl patch deployment coredns \
#    -n kube-system \
#    --type json \
#    -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'