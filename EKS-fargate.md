# eks falgate start

### falgate ecs cluster μμ±

```bash
eksctl create cluster --name kstadium --region ap-northeast-2 \
--vpc-private-subnets <PRIVATE_SUBNETS> \
--vpc-public-subnets <PUBLIC_SUBNETS> --fargate
```

```
export role=arn:aws:iam::911781391110:role/myAmazonEKSClusterRole
export subnets=subnet-0001fc5fe00d2deec,subnet-0c87a767cbf73557b
export sg=eks-default
aws eks create-cluster --name gndchain --role-arn $role --resources-vpc-config subnetIds=$subnets,securityGroupIds=$sg
```

<aside>
π‘ consoleμμ μμ± νλ€κ° cliλ‘ μμ± νλ©΄ λμ€μ cliλ‘ μ μ μ access deny λ‘ κ³ μ ν  μλ μλ€. κ°λ₯νλ©΄ cli νκ²½μμ μΌκ΄μ μΌλ‘ μμμ νλλ‘ νμ
</aside>

</br>

### fagate profile μμ±

```bash
aws eks update-kubeconfig --region ap-northeast-2 --name kstadium
```
νμΈ
```bash
β― kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   172.20.0.1   <none>        443/TCP   16m
β― kubectl get node
NAME                                                      STATUS   ROLES    AGE   VERSION
fargate-ip-10-10-24-108.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
fargate-ip-10-10-32-230.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
β― kubectl get nodes
NAME                                                      STATUS   ROLES    AGE   VERSION
fargate-ip-10-10-24-108.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
fargate-ip-10-10-32-230.ap-northeast-2.compute.internal   Ready    <none>   39m   v1.24.9-eks-300e41d
```
ν΄λ¬μ€ν°μ λν λ€νΈμνΉ(Networking) μΉμμ AWS Management Consoleμμ ν΄λΉ ν΄λ¬μ€ν°μ λν λ³΄μ κ·Έλ£Ήμ νμΈν  μ μμ΅λλ€. λλ λ€μ AWS CLI λͺλ Ήμ μ¬μ©νμ¬ νμΈν  μ μμ΅λλ€. μ΄ λͺλ Ήμ μ¬μ©νλ κ²½μ° my-clusterλ₯Ό ν΄λ¬μ€ν°μ μ΄λ¦μΌλ‘ λ°κΏλλ€.
```
aws eks describe-cluster --name my-cluster --query cluster.resourcesVpcConfig.clusterSecurityGroupId
```