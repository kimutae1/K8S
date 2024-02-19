#eksctl을 사용하여 IAM 그룹을 EKS 클러스터에 추가하려면 다음 단계를 따르세요.
#eksctl을 사용하여 클러스터 구성 파일을 생성합니다. 구성 파일은 YAML 형식으로 작성됩니다.
export cluster=kstadium
eksctl utils associate-iam-oidc-provider --cluster=$cluster --approve
#구성 파일을 열어서 iam 섹션에 mappings 항목을 추가합니다.

apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: <cluster_name>
  region: <region>
iam:
  withOIDC: true
  mappings:
    - groupARN: <IAM_group_ARN>
      rolearn: <IAM_role_ARN>
      username: <username>
구성 파일을 저장한 후, eksctl을 사용하여 클러스터에 적용합니다.
lua
Copy code
eksctl create iamidentitymapping -f <config_file.yaml>
IAM 그룹이 EKS 클러스터에 추가되었는지 확인합니다.
css
Copy code
aws eks describe-identity-mapping --cluster-name <cluster_name> --identity-type IAM --principal-arn <IAM_group_ARN>
위 명령어를 실행하면 identityName 속성에 <username>이 표시되는 것을 볼 수 있습니다. 이제 해당 IAM 그룹의 사용자는 EKS 클러스터에서 Kubernetes API에 액세스할 수 있습니다.





