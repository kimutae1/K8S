### mini cube setting


Installation
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

https://kubernetes.io/ko/docs/tutorials/hello-minikube/

### Hello Minikube
이 튜토리얼에서는 Minikube와 Katacoda를 이용하여 쿠버네티스에서 샘플 애플리케이션을 어떻게 실행하는지 살펴본다. Katacode는 무료로 브라우저에서 쿠버네티스 환경을 제공한다.

참고: 로컬에서 Minikube를 설치했다면 이 튜토리얼도 따라 할 수 있다. 설치 안내는 minikube 시작을 참고한다.
목적
샘플 애플리케이션을 minikube에 배포한다.
배포한 애플리케이션을 실행한다.
애플리케이션의 로그를 확인한다.
### 시작하기 전에
이 튜토리얼은 NGINX를 사용해서 모든 요청에 응답하는 컨테이너 이미지를 제공한다.

##minikube 클러스터 만들기
Launch Terminal 을 클릭
Launch Terminal
참고: minikube를 로컬에 설치했다면 minikube start를 실행한다. minikube dashboard 명령을 실행하기 전에, 새 터미널을 열고, 그 터미널에서 minikube dashboard 명령을 실행한 후, 원래의 터미널로 돌아온다.
브라우저에서 쿠버네티스 대시보드를 열어보자.

minikube dashboard
Katacoda 환경에서는: 터미널 패널의 상단에서 플러스를 클릭하고, 이어서 Select port to view on Host 1 을 클릭

Katacoda 환경에서는: 30000 을 입력하고 Display Port 를 클릭.

참고:
minikube dashboard 명령을 내리면 대시보드 애드온과 프록시가 활성화되고 해당 프록시로 접속하는 기본 웹 브라우저 창이 열린다. 대시보드에서 디플로이먼트나 서비스와 같은 쿠버네티스 자원을 생성할 수 있다.

root 환경에서 명령어를 실행하고 있다면, URL을 이용하여 대시보드 접속하기를 참고한다.

기본적으로 대시보드는 쿠버네티스 내부 가상 네트워크 안에서만 접근할 수 있다. dashboard 명령은 쿠버네티스 가상 네트워크 외부에서 대시보드에 접근할 수 있도록 임시 프록시를 만든다.

Ctrl+C 를 눌러 프록시를 종료할 수 있다. 대시보드는 종료되지 않고 실행 상태로 남아 있다. 명령이 종료된 후 대시보드는 쿠버네티스 클러스터에서 계속 실행된다. dashboard 명령을 다시 실행하여 대시보드에 접근하기 위한 다른 프록시를 생성할 수 있다.

URL을 이용하여 대시보드 접속하기
자동으로 웹 브라우저가 열리는 것을 원치 않는다면, --url 플래그와 함께 다음과 같은 명령어를 실행하여 대시보드 접속 URL을 출력할 수 있다.

```
minikube dashboard --url
```
디플로이먼트 만들기
쿠버네티스 파드는 관리와 네트워킹 목적으로 함께 묶여 있는 하나 이상의 컨테이너 그룹이다. 이 튜토리얼의 파드에는 단 하나의 컨테이너만 있다. 쿠버네티스 디플로이먼트는 파드의 헬스를 검사해서 파드의 컨테이너가 종료되었다면 재시작해준다. 파드의 생성 및 스케일링을 관리하는 방법으로 디플로이먼트를 권장한다.

kubectl create 명령어를 실행하여 파드를 관리할 디플로이먼트를 만든다. 이 파드는 제공된 Docker 이미지를 기반으로 한 컨테이너를 실행한다.

```
kubectl create deployment hello-node --image=registry.k8s.io/echoserver:1.4
```
디플로이먼트 보기

```
kubectl get deployments
```
다음과 유사하게 출력된다.

```
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   1/1     1            1           1m
```

파드 보기
```
kubectl get pods
```
다음과 유사하게 출력된다.

```
NAME                          READY     STATUS    RESTARTS   AGE
hello-node-5f76cf6ccf-br9b5   1/1       Running   0          1m
```

클러스터 이벤트 보기
```
kubectl get events
```

kubectl 환경설정 보기
```
kubectl config view
```
참고: kubectl 명령어에 관해 자세히 알기 원하면 kubectl 개요을 살펴보자.
서비스 만들기
기본적으로 파드는 쿠버네티스 클러스터 내부의 IP 주소로만 접근할 수 있다. hello-node 컨테이너를 쿠버네티스 가상 네트워크 외부에서 접근하려면 파드를 쿠버네티스 서비스로 노출해야 한다.

kubectl expose 명령어로 퍼블릭 인터넷에 파드 노출하기

kubectl expose deployment hello-node --type=LoadBalancer --port=8080
--type=LoadBalancer플래그는 클러스터 밖의 서비스로 노출하기 원한다는 뜻이다.

registry.k8s.io/echoserver 이미지 내의 애플리케이션 코드는 TCP 포트 8080에서만 수신한다. kubectl expose를 사용하여 다른 포트를 노출한 경우, 클라이언트는 다른 포트에 연결할 수 없다.

생성한 서비스 살펴보기

kubectl get services
다음과 유사하게 출력된다.

NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
hello-node   LoadBalancer   10.108.144.78   <pending>     8080:30369/TCP   21s
kubernetes   ClusterIP      10.96.0.1       <none>        443/TCP          23m
로드 밸런서를 지원하는 클라우드 공급자의 경우에는 서비스에 접근할 수 있도록 외부 IP 주소가 프로비저닝 한다. minikube에서 LoadBalancer타입은 minikube service 명령어를 통해서 해당 서비스를 접근할 수 있게 한다.

다음 명령어를 실행한다

minikube service hello-node
Katacoda 환경에서만: 플러스를 클릭한 후에 Select port to view on Host 1 를 클릭.

Katacoda 환경에서만: 서비스 출력에서 8080의 반대편에 표시되는 5자리 포트 번호를 기록 한다. 이 포트 번호는 무작위로 생성되며, 사용자마다 다를 수 있다. 포트 번호 텍스트 상자에 포트 번호를 입력한 다음, 포트 표시를 클릭한다. 이전 예시를 사용해서 30369 를 입력한다.

이렇게 하면 당신의 앱을 서비스하는 브라우저 윈도우를 띄우고 애플리케이션의 응답을 볼 수 있다.

애드온 사용하기
minikube 툴은 활성화하거나 비활성화할 수 있고 로컬 쿠버네티스 환경에서 접속해 볼 수 있는 내장 애드온 셋이 포함되어 있다.

현재 지원하는 애드온 목록을 확인한다.

minikube addons list
다음과 유사하게 출력된다.

addon-manager: enabled
dashboard: enabled
default-storageclass: enabled
efk: disabled
freshpod: disabled
gvisor: disabled
helm-tiller: disabled
ingress: disabled
ingress-dns: disabled
logviewer: disabled
metrics-server: disabled
nvidia-driver-installer: disabled
nvidia-gpu-device-plugin: disabled
registry: disabled
registry-creds: disabled
storage-provisioner: enabled
storage-provisioner-gluster: disabled
애드온을 활성화 한다. 여기서는 metrics-server를 예시로 사용한다.

minikube addons enable metrics-server
다음과 유사하게 출력된다.

The 'metrics-server' addon is enabled
생성한 파드와 서비스를 확인한다.

kubectl get pod,svc -n kube-system
다음과 유사하게 출력된다.

NAME                                        READY     STATUS    RESTARTS   AGE
pod/coredns-5644d7b6d9-mh9ll                1/1       Running   0          34m
pod/coredns-5644d7b6d9-pqd2t                1/1       Running   0          34m
pod/metrics-server-67fb648c5                1/1       Running   0          26s
pod/etcd-minikube                           1/1       Running   0          34m
pod/influxdb-grafana-b29w8                  2/2       Running   0          26s
pod/kube-addon-manager-minikube             1/1       Running   0          34m
pod/kube-apiserver-minikube                 1/1       Running   0          34m
pod/kube-controller-manager-minikube        1/1       Running   0          34m
pod/kube-proxy-rnlps                        1/1       Running   0          34m
pod/kube-scheduler-minikube                 1/1       Running   0          34m
pod/storage-provisioner                     1/1       Running   0          34m

NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
service/metrics-server         ClusterIP   10.96.241.45    <none>        80/TCP              26s
service/kube-dns               ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP       34m
service/monitoring-grafana     NodePort    10.99.24.54     <none>        80:30002/TCP        26s
service/monitoring-influxdb    ClusterIP   10.111.169.94   <none>        8083/TCP,8086/TCP   26s
metrics-server 비활성화

minikube addons disable metrics-server
다음과 유사하게 출력된다.

metrics-server was successfully disabled
제거하기
이제 클러스터에서 만들어진 리소스를 제거할 수 있다.

kubectl delete service hello-node
kubectl delete deployment hello-node
필요하면 Minikube 가상 머신(VM)을 정지한다.

minikube stop
필요하면 minikube VM을 삭제한다.

minikube delete
다음 내용
디플로이먼트 오브젝트에 대해서 더 배워 본다.
애플리케이션 배포에 대해서 더 배워 본다.
서비스 오브젝트에 대해서 더 배워 본다.