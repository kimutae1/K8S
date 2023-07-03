1. Kubernetes 인증서
기술적인 세부 사항을 설명하기 전에 몇 가지 용어를 정의해야 합니다. “TLS 인증서”는 Ingress Controller에서 HTTPS 연결을 활성화하는 데 필요한 두 가지 구성 요소를 나타냅니다.

인증서(Certificate)
개인키(Private Key)
인증서와 개인키는 모두 Let’s Encrypt에서 발급합니다. TLS 인증서 작동 방식에 대한 자세한 설명은 DigiCert의 TLS/SSL 인증서 작동 방식 게시물을 참조하십시오.

Kubernetes에서 이 두 구성 요소는 Secrets로 저장됩니다. NGINX Ingress Controller 및 cert-manager와 같은 Kubernetes workload는 이러한 Secrets을 쓰고 읽을 수 있으며, Kubernetes 설치에 대한 액세스 권한이 있는 사용자가 관리할 수도 있습니다.

1-1. cert-manager 소개
cert-manager 프로젝트는 Kubernetes 및 OpenShift에서 작동하는 인증서 컨트롤러입니다. Kubernetes에 배포될 때 cert-manager는 자동으로 Ingress controller에 필요한 인증서를 발급하고 인증서가 유효하고 최신 상태인지 확인합니다. 또한 인증서의 만료 날짜를 추적하고 구성된 시간 간격으로 갱신을 시도합니다. 수많은 공공 및 민간 발행자와 함께 작동하지만 Let’s Encrypt의 통합하는 과정을 살펴 보겠습니다.

Cert Manager diagram
1-2. 두 가지 유형
Let’s Encrypt 사용 시 모든 인증서 관리가 자동으로 처리됩니다. 이 기능은 많은 편의성을 제공하지만 다음과 같은 문제도 제시합니다. 서비스에서 해당 정규화된 도메인 이름(FQDN)을 소유하도록 보장하는 방법은 무엇입니까?

이 문제는 특정 도메인의 DNS 레코드에 대한 액세스 권한이 있는 사람만 제공할 수 있는 확인 요청에 응답 하는 것으로 해결됩니다. 다음 두 가지 유형에 대해 살펴 보겠습니다.

1. HTTP-01: 이 과정은 인증서를 발급하는 FQDN에 대한 DNS 레코드가 있으면 응답할 수 있습니다. 예를 들어, 서버가 IP http://www.xxx.yyy.zzz이고 FQDN이 cert.example.com인 경우 인증 메커니즘은 http://www.xxx.yyy.zzz에 있는 서버의 토큰을 노출하고 Let’s Encrypt 서버는 cert.example.com을 통해 연결을 시도합니다. 성공하면 통과되고 인증서가 발급 됩니다.

HTTP-01은 DNS 공급자에 직접 액세스할 필요가 없으므로 인증서를 생성하는 가장 간단한 방법입니다. 이러한 유형의 시도는 항상 포트 80(HTTP)을 통해 수행됩니다. HTTP-01를 사용할 때 cert-manager는 Ingress Controller를 활용하여 토큰을 제공합니다.

HTTP-01 diagram
2. DNS-01: 이 과정은 토큰으로 DNS TXT 레코드를 생성한 다음 발급자가 이를 확인합니다. 토큰이 인식되면 해당 도메인의 소유권을 증명한 것이며 이제 해당 레코드에 대한 인증서를 발급할 수 있습니다. HTTP-01와 달리 DNS-01를 사용할 때 FQDN은 서버의 IP 주소로 확인할 필요가 없습니다. 또한 포트 80이 차단된 경우 DNS-01을 사용할 수 있습니다. 이러한 사용 편의성에 대한 상쇄는 인증서 관리자 설치에 대한 API 토큰을 통해 DNS 인프라에 대한 액세스를 제공해야 한다는 것 입니다.

DNS-01 diagram
1-3. Ingress Controller
Ingress Controller는 클러스터 외부에서 트래픽을 가져와 내부 하나 이상의 컨테이너 그룹(Pod)에 로드 밸런싱하고 Egress 트래픽을 관리하는 Kubernetes용 전문 서비스입니다. 또한 Ingress Controller는 Kubernetes API를 통해 제어되며 Pod가 추가, 제거 또는 실패할 때 로드 밸런싱 구성을 모니터링 및 업데이트합니다.

2. 인증서 관리 예제
이 예에서는 테스트할 수 있는 작동 중인 Kubernetes 설치가 있고 설치에서 외부 IP 주소(Kubernetes 로드 밸런서 객체)를 할당할 수 있다고 가정합니다. 또한 포트 80과 포트 443(HTTP-01) 또는 포트 443(DNS-01)에서 트래픽을 수신할 수 있다고 가정합니다. 이러한 예는 Mac OS를 사용하여 설명되지만 Linux 또는 WSL에서도 사용할 수 있습니다.

A 레코드를 조정할 수 있는 DNS 공급자와 FQDN도 필요합니다. HTTP-01를 사용하는 경우 A 레코드를 추가할 수 있는 기능만 있으면 됩니다. DNS-01를 사용하는 경우 지원되는 DNS 공급자 또는 지원되는 웹 훅 공급자에 대한 API 액세스가 필요합니다.

2-1. NGINX Ingress Controller 배포
가장 쉬운 방법은 Helm를 통해 배포하는 것 입니다. 이 배포를 통해 Kubernetes Engress 및 NGINX Virtual Server CRD를 모두 사용할 수 있습니다.

1. NGINX 저장소 추가

$ helm repo add nginx-stable https://helm.nginx.com/stable

  "nginx-stable" has been added to your repositories 
2. 저장소 업데이트

$ helm repo update

 Hang tight while we grab the latest from your chart repositories...
  ...Successfully got an update from the "nginx-stable" chart repository
  Update Complete. ⎈Happy Helming!⎈ 
3. Ingress Controller 설치 및 배포

$ helm install nginx-kic nginx-stable/nginx-ingress \
  --namespace nginx-ingress  --set controller.enableCustomResources=true \ 
  --create-namespace  --set controller.enableCertManager=true

  NAME: nginx-kic
  LAST DEPLOYED: Thu Sep  1 15:58:15 2022
  NAMESPACE: nginx-ingress
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None
  NOTES:
  The NGINX Ingress Controller has been installed. 
4. Ingress Controller 배포를 확인하고 IP 주소를 확인 합니다.

$ kubectl get deployments --namespace nginx-ingress

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
  nginx-kic-nginx-ingress   1/1     1            1           23s
$ kubectl get services --namespace nginx-ingress

NAME                      TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
  nginx-kic-nginx-ingress   LoadBalancer   10.128.60.190   www.xxx.yyy.zzz   80:31526/TCP,443:32058/TCP   30s
2-2. DNS A 레코드 추가
여기에서 프로세스는 DNS 공급자에 따라 다릅니다. 이 DNS 이름은 Let’s Encrypt 서버에서 확인할 수 있어야 하며, 작동하기 전에 레코드가 전파될 때까지 기다려야 할 수 있습니다. 이에 대한 자세한 내용은 SiteGround 문서 DNS 전파란 무엇이며 왜 그렇게 오래 걸리나요?를 참조하십시오.

선택한 FQDN을 확인할 수 있으면 다음 단계로 이동할 준비가 되었습니다.

$ host cert.example.com

cert.example.com has address www.xxx.yyy.zzz
2-3. cert-manager 배포
다음 단계는 최신 버전의 cert-manager를 배포하는 것입니다. 다시 말하지만, 배포에 Helm을 사용할 것입니다.

1. NGINX 저장소 추가

$ helm repo add jetstack https://charts.jetstack.io

  "jetstack" has been added to your repositories 
2. 저장소 업데이트

$ helm repo update

  Hang tight while we grab the latest from your chart repositories...
  ...Successfully got an update from the "nginx-stable" chart repository
  ...Successfully got an update from the "jetstack" chart repository
  Update Complete. ⎈Happy Helming!⎈ 
3. cert-manager 설치 및 배포

$ helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager --create-namespace \
  --version v1.9.1  --set installCRDs=true

  NAME: cert-manager
  LAST DEPLOYED: Thu Sep  1 16:01:52 2022 
  NAMESPACE: cert-manager
  STATUS: deployed
  REVISION: 1 
  TEST SUITE: None
  NOTES:
  cert-manager v1.9.1 has been deployed successfully!

  In order to begin issuing certificates, you will need to set up a ClusterIssuer
  or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

  More information on the different types of issuers and how to configure them
  can be found in our documentation:

  https://cert-manager.io/docs/configuration/

  For information on how to configure cert-manager to automatically provision
  Certificates for Ingress resources, take a look at the `ingress-shim`
  documentation:

  https://cert-manager.io/docs/usage/ingress/
4. 배포가 되었는지 확인 합니다.

$ kubectl get deployments --namespace cert-manager

  NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
  cert-manager              1/1     1            1           4m30s
  cert-manager-cainjector   1/1     1            1           4m30s
  cert-manager-webhook      1/1     1            1           4m30s 
2-4. NGINX Cafe 배포 예제
NGINX Cafe 예제를 사용하여 backend 배포 및 서비스를 제공할 예정입니다. 이것은 NGINX가 제공한 문서에서 사용되는 일반적인 예입니다.

1. NGINX Ingress Github 클론(Clone)

$ git clone https://github.com/nginxinc/kubernetes-ingress.git

  Cloning into 'kubernetes-ingress'...
  remote: Enumerating objects: 44979, done.
  remote: Counting objects: 100% (172/172), done.
  remote: Compressing objects: 100% (108/108), done.
  remote: Total 44979 (delta 87), reused 120 (delta 63), pack-reused 44807
  Receiving objects: 100% (44979/44979), 60.27 MiB | 27.33 MiB/s, done.
  Resolving deltas: 100% (26508/26508), done. 
2. complate-example 디렉토리로 변경합니다. 이 디렉토리에는 Ingress controller의 다양한 구성을 보여주는 몇 가지 예가 포함되어 있습니다.

$ cd ./kubernetes-ingress/examples/ingress-resources/complete-example
3. NGINX Cafe 예제를 배포 합니다.

$ kubectl apply -f ./cafe.yaml

  deployment.apps/coffee created
  service/coffee-svc created
  deployment.apps/tea created
  service/tea-svc created
4. kubectl get 명령을 사용하여 배포 및 서비스 상태를 확인합니다. READY가 전부 실행 중 이어야 합니다.

$ kubectl get deployments,services  --namespace default

  NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
  deployment.apps/coffee   2/2     2            2           69s
  deployment.apps/tea      3/3     3            3           68s
2-5. Clusterlssuer 배포
cert-manager 내에서 Clusterlssuer를 사용하여 인증서를 발급할 수 있습니다. 이것은 모든 네임스페이스에서 참조할 수 있고 정의된 인증서 발급 권한을 가진 모든 인증서 요청에 사용할 수 있는 클러스터 범위 개체입니다. 이 예제에서 Let’s Encrypt 인증서에 대한 인증서 요청은 Clusterlssuer에서 처리할 수 있습니다.

선택한 문제 유형에 대해 Clusterlssuer를 배포합니다. 이 게시물의 범위를 벗어났지만 Clusterlssuer에 여러 해석기를 지정할 수 있는 고급 구성 옵션이 있습니다.

2-6. ACME 기본 사항
ACME(Automated Certificate Management Environment) 프로토콜은 사용자가 도메인 이름을 소유하고 있는지 확인하는 데 사용되므로 암호화 인증서를 발급 받을 수 있습니다. 이 문제를 해결하려면 다음 매개 변수를 전달해야 합니다.

metadata.name: Kubernetes: 설치 내에서 고유해야 하는 ClusterIssuer 이름입니다. 이 이름은 나중에 인증서를 발급할 때 사용됩니다.
spec.acme.emall: 인증서 생성을 위해 Let’s Encrypt에 등록하는 이메일 주소입니다. 이것은 당신의 이메일이어야 합니다.
spec.acme.privateKeySecretRef: 이것은 개인 키를 저장하는 데 사용할 Kubernetes secret의 이름입니다.
spec.acme.solvers: 이 값은 그대로 두어야 합니다. 사용 중인 과제 유형(또는 ACME에서 언급하는 solver)과 이를 적용해야 하는 입력 클래스(이 경우 nginx)를 기록합니다.
2-7. HTTP-01 사용
이 예제는 HTTP-01를 사용하여 도메인 소유권을 증명하고 인증서를 받도록 ClusterIssuer를 설정하는 방법을 보여 줍니다.

HTTP-01을 사용하여 ClusterIssuer를 만듭니다.
$ cat << EOF | kubectl apply -f 
  apiVersion: cert-manager.io/v1
  kind: ClusterIssuer
  metadata:
    name: prod-issuer
  spec:
    acme:
      email: example@example.com
      server: https://acme-v02.api.letsencrypt.org/directory
      privateKeySecretRef:
        name: prod-issuer-account-key
      solvers:
      - http01:
         ingress:
           class: nginx
  EOF
2. ClusterIssuer의 유효성을 검사합니다. (READY가 True여야 합니다.)

$ kubectl get cluster-issuer

  NAME          READY   AGE
  prod-issuer   True    34s 
2-8. DNS-01 사용
이 예제는 DNS-01를 사용하여 도메인 소유권을 인증하도록 ClusterIssuer를 설정하는 방법을 보여 줍니다. DNS 공급자에 따라 토큰을 저장하기 위해 Kubernetes Secret을 사용해야 할 수 있습니다. 이 예제는 Cloudflare를 사용합니다. 네임스페이스의 사용에 주의하십시오. cert-manager 네임스페이스에 배포된 cert-manager 애플리케이은 Secret에 대한 액세스 권한이 있어야 합니다.

Cloudflare API 토큰이 필요하며, 이 토큰은 계정에서 생성할 수 있습니다. 아래  <API Token> 줄에 입력해야 합니다. Cloudflare를 사용하지 않는 경우 해당 공급자의 설명서를 따라야 합니다.

1. API token Secret 생성

$ cat << EOF | kubectl apply -f 
  apiVersion: v1
  kind: Secret
  metadata:
    name: cloudflare-api-token-secret
    namespace: cert-manager
  type: Opaque
  stringData:
    api-token: <API Token> 
  EOF
2. DNS-01을 사용하여 발급자를 생성합니다.

$ cat << EOF | kubectl apply -f 
  apiVersion: cert-manager.io/v1
  kind: ClusterIssuer
  metadata:
    name: prod-issuer
  spec:
    acme:
      email: example@example.com
      server: https://acme-v02.api.letsencrypt.org/directory
      privateKeySecretRef:
        name: prod-issuer-account-key
      solvers:
        - dns01:
            cloudflare:
              apiTokenSecretRef:
                name: cloudflare-api-token-secret
                key: api-token
  EOF
3. 발급자의 유효성을 확인합니다. (READY가 True여야 합니다.)

$ kubectl get clusterissuer

  NAME          READY   AGE
  prod-issuer   True    31m 
2-9. Ingress 배포
애플리케이션을 위한 Ingress resource 배포입니다. 이렇게 하면 이전에 배포한 NGINX Cafe 애플리케이션으로 트래픽이 라우팅 됩니다.

2-10. Kubernetes Ingress 배포
표준 Kubernetes Ingress resource를 사용하는 경우 다음 배포 YAML을 사용하여 Ingress를 구성하고 인증서를 요청합니다.

apiVersion: networking.k8s.io/v1 
  kind: Ingress 
  metadata: 
    name: cafe-ingress 
    annotations: 
      cert-manager.io/cluster-issuer: prod-issuer 
      acme.cert-manager.io/http01-edit-in-place: "true" 
  spec: 
    ingressClassName: nginx 
    tls: 
    - hosts: 
      - cert.example.com 
      secretName: cafe-secret 
    rules: 
    - host: cert.example.com 
      http: 
        paths: 
        - path: /tea 
          pathType: Prefix 
          backend: 
            service: 
              name: tea-svc 
              port: 
                number: 80 
        - path: /coffee 
          pathType: Prefix 
          backend: 
            service: 
              name: coffee-svc 
              port: 
number: 80
manifest의 몇 가지 주요 부분을 알아 보겠습니다.

호출되는 API는 표준 Kubernetes Ingress입니다.
이 구성의 핵심 부분은 acme.cert-manager.io/http01-edit-in-place을 “true”로 설정한 metadata.consulations 아래에 있습니다. 이 값은 필수이며 문제가 해결되는 방식을 조정합니다.
spec.ingressClassName은 설치 및 사용 중인 NGINX 입력 컨트롤러를 나타냅니다.
spec.tls.secret Kubernetes Secret resource는 Let’s Encrypt에서 인증서를 발급할 때 반환 되는 인증서 키를 저장합니다.
cert.example.com의 호스트 이름은 spec.tls.hosts 및 spec.rules.host에 대해 지정됩니다. 이것은 ClusterIssuer가 인증서를 발급한 호스트 이름입니다.
spec.rules.http 섹션은 해당 경로에서 요청을 처리할 backend 서비스를 정의합니다. 예를 들어 /tea에 대한 트래픽은 tea-svc의 포트 80으로 전달됩니다.
1. 설치를 위해 위의manifest를 수정합니다. 최소한 spec.rules.host 및 spec.tls.hosts 값을 변경 하지만 구성의 모든 매개변수를 검토해야 합니다.

2. manifest 적용

kubectl apply -f ./cafe-virtual-server.yaml

  virtualserver.k8s.nginx.org/cafe created 
3. 인증서가 발급될 때까지 기다립니다. READY 필드에 “True”값이 나와야 합니다.

kubectl get certificates

  NAME                                      READY   SECRET        AGE
  certificate.cert-manager.io/cafe-secret   True    cafe-secret   37m 
2-11. NGINX 가상 서버(Virtual Server)/가상 경로 설정(Virtual Routes)
NGINX CRDs를 사용하는 경우 다음 배포 YAML을 사용하여 Ingress를 구성해야 합니다.

apiVersion: k8s.nginx.org/v1 
  kind: VirtualServer 
  metadata: 
    name: cafe 
  spec: 
    host: cert.example.com 
    tls: 
      secret: cafe-secret 
      cert-manager: 
        cluster-issuer: prod-issuer 
    upstreams: 
    - name: tea 
      service: tea-svc 
      port: 80 
    - name: coffee 
      service: coffee-svc 
      port: 80 
    routes: 
    - path: /tea 
      action: 
        pass: tea 
    - path: /coffee 
      action: 
pass: coffee
다시 한번 manifest의 몇 가지 주요 부분을 확일할 필요가 있습니다.

호출되는 API는 VirtualServer 리소스에 대한 NGINX 특정 k8s.nginx.org/v1입니다.
spec.tls.secret Kubernetes Secret resource는 Let’s Encrypt에 의해 인증서가 발급될 때 반환되는 인증서 키를 저장합니다.
cert.example.com의 호스트 이름은 spec.host에 대해 지정됩니다. 이것은 ClusterIssuer가 인증서를 발급한 호스트 이름입니다.
spec.upstreams 값은 포트를 포함한 backend 서비스를 가리킵니다.
spec.routes는 해당 경로가 적중 되었을 때 수행할 작업을 모두 정의합니다.
1. 설치를 위해 위의manifest를 수정합니다. 최소한 spec.host 값을 변경 하지만 구성의 모든 매개변수를 검토해야 합니다.

2. manifest 적용

$ kubectl apply -f ./cafe-virtual-server.yaml

  virtualserver.k8s.nginx.org/cafe created
3. 인증서가 발급될 때까지 기다립니다. (STATE가 Valid로 표시 되어야 합니다.)

$ kubectl get VirtualServers

  NAME   STATE   HOST                    IP             PORTS      AGE
  cafe   Valid   cert.example.com   www.xxx.yyy.zzz   [80,443]   51m 
2-12. 인증서 확인
Kubernetes API를 통해 인증서를 볼 수 있습니다. 인증서 크기 및 관련 개인 키를 포함하여 인증서에 대한 세부 정보를 표시합니다.

$ kubectl describe secret cafe-secret
  Name:         cafe-secret
  Namespace:    default
  Labels:       <none>
  Annotations:  cert-manager.io/alt-names: cert.example.com
                cert-manager.io/certificate-name: cafe-secret
                cert-manager.io/common-name: cert.example.com
                cert-manager.io/ip-sans:
                cert-manager.io/issuer-group:
                cert-manager.io/issuer-kind: ClusterIssuer
                cert-manager.io/issuer-name: prod-issuer
                cert-manager.io/uri-sans:Type:  kubernetes.io/tlsData
  ====
  tls.crt:  5607 bytes
  tls.key:  1675 bytes 
실제 인증서와 키를 보려면 다음 명령을 실행하면 됩니다. (참고: 이것은 Kubernetes Secrets의 약점을 보여줍니다. 즉, 필요한 액세스 권한이 있는 모든 사람이 읽을 수 있습니다.)

$ kubectl get secret cafe-secret -o yaml
2-13. Ingress 테스트
인증서를 테스트합니다. 여기서 원하는 방법을 사용할 수 있습니다. 아래의 예제는 cURL을 사용합니다. 성공은 서버 이름, 서버의 내부 주소, 날짜, 선택한 URI(coffee or tea) 및 요청 ID를 포함하는 이전에 표시된 것과 유사한 블록으로 표시됩니다. 실패는 HTTP 오류 코드의 형태를 취하며 대부분 400 또는 301입니다.

$ curl https://cert.example.com/tea

Server address: 10.2.0.6:8080
Server name: tea-5c457db9-l4pvq
Date: 02/Sep/2022:15:21:06 +0000
URI: /tea
Request ID: d736db9f696423c6212ffc70cd7ebecf
$ curl https://cert.example.com/coffee

Server address: 10.2.2.6:8080
Server name: coffee-7c86d7d67c-kjddk
Date: 02/Sep/2022:15:21:10 +0000
URI: /coffee
Request ID: 4ea3aa1c87d2f1d80a706dde91f31d54 
3. 어떤 유형을 선택 해야 하는가?
이는 주로 사용 사례에 따라 다릅니다.

HTTP-01 방법을 사용하려면 포트 80이 열려 있어야 하고 DNS A 레코드가 Ingress Controller의 IP 주소에 대해 올바르게 구성되어 있어야 합니다. 이 접근 방식에서는 A 레코드를 만드는 것 외에는 DNS 공급자에 대한 액세스가 필요하지 않습니다.

DNS-01 방법은 포트 80을 인터넷에 노출할 수 없을 때 사용할 수 있으며 인증서 관리자가 DNS 공급자에 대한 egress 액세스 권한만 있으면 됩니다. 그러나 이 방법을 사용하려면 DNS 공급자의 API에 대한 액세스 권한이 있어야 하지만 필요한 액세스 수준은 특정 공급자에 따라 다릅니다.