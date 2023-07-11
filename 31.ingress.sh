# app-admin deployment yaml 생성
cat <<EOF > app-admin-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: app-deployment
  template:
    metadata:
      labels:
        app: app-deployment
    spec:
      containers:
      - name: app-deployment
        image: 911781391110.dkr.ecr.ap-northeast-2.amazonaws.com/develop/app-admin:latest
        ports:
        - containerPort: 3000
EOF

# admin-admin service 생성
cat <<EOF > app-admin-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: app-deployment
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
  type: NodePort
EOF

# app-admin ingress 생성
cat <<EOF > app-admin-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app-service
            port:
              number: 80
EOF

kubectl apply -f app-admin-ingress.yaml
kubectl apply -f app-admin-service.yaml
kubectl apply -f app-admin-deployment.yaml