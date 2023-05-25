#!/bin/bash

eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve


###o

eksctl create iamserviceaccount \
  --cluster=$cluster_name \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::${Account}:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve



###subnet tag add
for x in ${public_a} ${public_c} ${private_a} ${private_c} ; do aws ec2 create-tags --resources $x --tags Key=kubernetes.io/cluster/$cluster_name,Value=owned ; done
for x in ${public_a} ${public_c}  ; do aws ec2 create-tags --resources $x --tags Key=kubernetes.io/role/elb,Value=1 ; done
for x in ${private_a} ${private_c}  ; do aws ec2 create-tags --resources $x --tags Key=kubernetes.io/role/internal-elb,Value=1 ; done


  ###
  eksctl get iamserviceaccount --cluster $cluster_name --name aws-load-balancer-controller --namespace kube-system

  ###helm
  helm repo add eks https://aws.github.io/eks-charts
  kubectl apply -k "github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller//crds?ref=master"

###alb install
  helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    --set clusterName=$cluster_name \
    --set serviceAccount.create=false \
    --set region=$region_code \
    --set vpcId=$VpcId \
    --set serviceAccount.name=aws-load-balancer-controller \
    --set subnets.public.enabled=true \
    -n kube-system
### rm alb
#helm uninstall aws-load-balancer-controller -n kube-system


### fargate profile
eksctl create fargateprofile --cluster $cluster_name --region $region_code --name your-alb-sample-app --namespace game-2048
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/examples/2048/2048_full.yaml
