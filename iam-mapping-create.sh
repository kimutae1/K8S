export REGION=ap-northeast-2
export REGION_CODE=911781391110
#export CLUSTER-NAME= dorian

eksctl create iamidentitymapping \
    --cluster kstadium \
    --region ap-northeast-2 \
    --arn arn:aws:iam::911781391110:user/dorian.kim@themedium.io \
    --group system:masters \
    --no-duplicate-arns \
    --username kstadium

