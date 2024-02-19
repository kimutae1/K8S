## AWS Info(example)
* REPO account_id :
  - 033240183289 (PRD)
    
* ECR Endpoint :
  - public.ecr.aws/j1t6w1m1/ekstools

* Image Endpoint :
  - public.ecr.aws/j1t6w1m1/ekstools:latest

## REPO PUSH 명령어

```
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j1t6w1m1
docker build -t ekstools .
docker tag ekstools:latest public.ecr.aws/j1t6w1m1/ekstools:latest
docker push public.ecr.aws/j1t6w1m1/ekstools:latest
```
