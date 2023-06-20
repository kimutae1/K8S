filename=53.nginx_fargate_exe.sh

cat << EOF >  ${filename}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment-fargate
  #namespace: node-add
spec:
  selector:
    matchLabels:
      eks.amazonaws.com/nodegroup: alb7-Node
  replicas: 2 
  template:
    metadata:
      labels:
        app: nginx
        env: production
        eks.amazonaws.com/nodegroup: alb7-Node # 추가된 라벨입니다.
        #alpha.eksctl.io/nodegroup-name: alb7-Node
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80

EOF

kubectl apply -f $filename