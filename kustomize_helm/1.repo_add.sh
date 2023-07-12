helm repo add argo https://argoproj.github.io/argo-helm
helm template my-argocd argo/argo-cd > temp.yaml

cat << EOF > add-config.yaml 
apiVersion: v1
kind: Namespace
metadata:
  name: managed
EOF

cat << EOF > my-values.yaml 
controller:
  replicas: 1
server:
  replicas: 1
  service:
    ingress: enable
    annotations:
     kubernetes.io/ingress.class: alb
    # kubernetes.io/ingress.class: nginx
    # nginx.ingress.kubernetes.io/rewrite-target: /
    labels: {}
    ingressClassName: alb

    type: NodePort
    #type: ClusterIP
    nodePortHttp: 30080
    nodePortHttps: 30443
    servicePortHttp: 80
    servicePortHttps: 443
    servicePortHttpName: http
    servicePortHttpsName: https
    namedTargetPort: true
    loadBalancerIP: ""
    loadBalancerSourceRanges: []
    externalIPs: []
    externalTrafficPolicy: ""
    sessionAffinity: ""
EOF


cat << EOF > kustomization.yaml 
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- add-config.yaml

helmCharts:
  - name: argo-cd
    repo: https://argoproj.github.io/argo-helm
    version: 3.26.5
    releaseName: my-argocd
    namespace: managed
    valuesFile: my-values.yaml 
    includeCRDs: true # CustomResourceDefinition 이 있을 경우 true
EOF


## 아래와 같은 secret 을 추가로 배포하기 위해 my-secret.yaml 파일을 생성합니다.
cat << EOF > my-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: namespace-secret
type: Opaque
stringData:
  id: kstadium
  password: devops
EOF

## kustomization.yaml 파일에 my-secret.yaml 리소스를 추가한다.
cat << EOF > kustomization.yaml
helmCharts:
  - name: argo-cd
    repo: https://argoproj.github.io/argo-helm
    version: 3.26.5
    releaseName: my-argocd
    namespace: managed
    valuesFile: my-values.yaml 
    includeCRDs: true

resources:
  - my-secret.yaml
EOF

kustomize build . --enable-helm > temp.yaml

kubectl create namespace managed
kubectl apply -f temp.yaml -n managed