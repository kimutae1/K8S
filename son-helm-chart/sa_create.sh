eksctl create iamserviceaccount \
  --cluster=alb7 \
  --namespace=node-add \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::911781391110:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve