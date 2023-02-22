kubectl get nodes --cluster dorian --region ap-northeast-2

aws sts get-caller-identity

{
    "UserId": "AIDA5ISTH5MDBSP4INYRD",
    "Account": "911781391110",
    "Arn": "arn:aws:iam::911781391110:user/dorian.kim@themedium.io"
}

kubectl -n kube-system get cm aws-iam-authenticator -o yaml 

eksctl utils write-kubeconfig --cluster=dorian
aws eks update-kubeconfig --region ap-northeast-2 --name dorian


eksctl get iamidentitymapping --cluster dorian --resion ap-northeast-2

eksctl create iamidentitymapping \
    --cluster dorian \
    --region ap-northeast-2 \
    --arn arn:aws:iam::911781391110:user/dorian.kim@themedium.io \
    --group system:masters \
    --no-duplicate-arns \
    --username arn:aws:iam::911781391110:user/dorian.kim@themedium.io
    admin-user1

    eksctl create iamidentitymapping 
    --cluster your_cluster_Name --region=your_region 
    --arn YOUR_IAM_ARN <arn:aws:iam::123456:role testing=""> 
    --group system:masters --username admin</arn:aws:iam::123456:role>


"arn:aws:iam::911781391110:user/dorian.kim@themedium.io"

    "Arn": "arn:aws:iam::911781391110:user/dorian.kim@themedium.io"

aws eks update-kubeconfig \
    --region ap-northeast-2 \
    --name dorian \
    --role-arn arn:aws:iam::911781391110:role/eksClusterRole
