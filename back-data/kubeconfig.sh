#export region=ap-northeast-2
#aws eks update-kubeconfig --region $region --name gndchain


#export REGION=ap-northeast-2
#export REGION_CODE=911781391110
##export CLUSTER-NAME= dorian
export CLUSTER=devel
export REGION=ap-northeast-2
export REGIONCODE=911781391110
export ARN=arn:aws:sts::911781391110:assumed-role/AWSReservedSSO_crypted_devops_1c74128b3bb9822e/dorian.kim@crypted.co.kr

#eksctl create iamidentitymapping \
#    --cluster $CLUSTER \
#    --region  $REGIONCODE \
#    --arn ${ARN} \
#    #--arn arn:aws:iam::911781391110:user/dorian.kim@themedium.io \
#    --group system:masters \
#    --no-duplicate-arns \
#    --username c9
#    
    
aws eks update-kubeconfig --region $REGION --name $CLUSTER
