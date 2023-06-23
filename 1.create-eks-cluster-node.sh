cat << EOF > eks-demo-cluster.yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
 name: ${cluster_name}
 region: ${region_code}

iam:
  serviceRoleARN: $role
  withOIDC: true

vpc:
  id: ${VpcId}
  cidr: ${CidrBlock}
  subnets:
    private:
      `aws ec2 describe-subnets --subnet-ids $private_a |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${private_a}
      `aws ec2 describe-subnets --subnet-ids $private_c |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${private_c}
    public:
      `aws ec2 describe-subnets --subnet-ids $public_a |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${public_a}
      `aws ec2 describe-subnets --subnet-ids $public_c |jq -r '.Subnets[].AvailabilityZone'`:
         id: ${public_c}

managedNodeGroups:
  - name: nodegroup # 클러스터의 노드 그룹명
    instanceType: m5.large # 클러스터 워커 노드의 인스턴스 타입
    desiredCapacity: 2 # 클러스터 워커 노드의 갯수
    volumeSize: 30  # 클러스터 워커 노드의 EBS 용량 (단위: GiB)
    privateNetworking: true
    ssh:
      enableSsm: true
    iam:
      #  withAddonPolicies:
      #    imageBuilder: true # Amazon ECR에 대한 권한 추가
      #    albIngress: true  # albIngress에 대한 권한 추가
      #    cloudWatch: true # cloudWatch에 대한 권한 추가
      #    autoScaler: true # auto scaling에 대한 권한 추가
      #    ebs: true # EBS CSI Driver에 대한 권한 추가
      instanceRoleARN: $role

cloudWatch:
  clusterLogging:
    enableTypes: ["*"]

EOF


cat eks-demo-cluster.yaml

eksctl create cluster -f eks-demo-cluster.yaml