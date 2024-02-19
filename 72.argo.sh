#url = https://whchoi98.gitbook.io/k8s/eks-cicd/argo-cd

#namespace - argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml

#cli
sudo curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.4.7/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

#loadbalancer를 이용한 노출
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`
echo $ARGOCD_SERVER

#초기 암호 // id = admin
export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
echo $ARGO_PWD

#cli login
argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure

#context를 이용하여 argocd와 연결
CONTEXT_NAME=`kubectl config view -o jsonpath='{.current-context}'`
argocd cluster add $CONTEXT_NAME


#애플리케이션을 구성하고 사용자의 Fork에 연결합니다.
kubectl create namespace ecsdemo-nodejs
export GITHUB_USERNAME=kimutae1
argocd app create ecsdemo-nodejs --repo https://github.com/${GITHUB_USERNAME}/ecsdemo-nodejs.git --path kubernetes --dest-server https://kubernetes.default.svc --dest-namespace ecsdemo-nodejs


#애플리케이션이 아직 배포되지 않았기 때문에 애플리케이션이 OutOfSync 상태에 있음을 알 수 있습니다. 이제 애플리케이션을 동기화합니다
argocd app sync ecsdemo-nodejs
