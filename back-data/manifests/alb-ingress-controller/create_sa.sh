export ACCOUNT_ID=911781391110
export cluster=devel
eksctl create iamserviceaccount \
    --cluster $cluster \
    --namespace kube-system \
    --name aws-load-balancer-controller \
    --attach-policy-arn arn:aws:iam::$ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --approve
