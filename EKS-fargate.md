# eks falgate start

### falgate ecs cluster 생성

```bash
eksctl create cluster --name kstadium --region ap-northeast-2 \
--vpc-private-subnets <PRIVATE_SUBNETS> \
--vpc-public-subnets <PUBLIC_SUBNETS> --fargate
```

<aside>
💡 console에서 생성 했다가 cli로 생성 하면 나중에 cli로 접속 시 access deny 로 고생 할 수도 있다. 가능하면 cli 환경에서 일관적으로 작업을 하도록 하자
</aside>

</br>

### fagate profile 생성

```bash
aws eks update-kubeconfig --region ap-northeast-2 --name kstadium
```
확인
```bash
❯ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   172.20.0.1   <none>        443/TCP   16m
❯ kubectl get node
NAME                                                      STATUS   ROLES    AGE   VERSION
fargate-ip-10-10-24-108.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
fargate-ip-10-10-32-230.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
❯ kubectl get nodes
NAME                                                      STATUS   ROLES    AGE   VERSION
fargate-ip-10-10-24-108.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
fargate-ip-10-10-32-230.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
```
클러스터에 대한 네트워킹(Networking) 섹션의 AWS Management Console에서 해당 클러스터에 대한 보안 그룹을 확인할 수 있습니다. 또는 다음 AWS CLI 명령을 사용하여 확인할 수 있습니다. 이 명령을 사용하는 경우 my-cluster를 클러스터의 이름으로 바꿉니다.
```
aws eks describe-cluster --name my-cluster --query cluster.resourcesVpcConfig.clusterSecurityGroupId
```