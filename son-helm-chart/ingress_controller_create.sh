helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    --set clusterName=alb7 \
    --set serviceAccount.create=false \
    --set region=ap-northeast-2 \
    --set vpcId=vpc-09a6049b96e74bf58 \
    --set serviceAccount.name=aws-load-balancer-controller \
    -n node-add