export REGION=ap-northeast-2
export REGION_CODE=911781391110
#export CLUSTER-NAME= dorian
export CLUSTER=albtest

eksctl create iamidentitymapping \
    --cluster $CLUSTER \
    --region ap-northeast-2 \
    --arn arn:aws:iam::911781391110:user/dorian.kim@themedium.io \
    --arn arn:aws:iam::911781391110:role/devops-role \
    --group system:masters \
    --no-duplicate-arns \
    --username kstadium

