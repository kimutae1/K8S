export REGION=ap-northeast-2
export REGION_CODE=911781391110
#export CLUSTER-NAME= dorian

eksctl create iamidentitymapping \
    --cluster dorian \
    --region ap-northeast-2 \
    --arn arn:aws:sts::911781391110:assumed-role/devops-role/botocore-session-1677054722 \
    --group system:masters \
    --no-duplicate-arns \
    --username dorian

