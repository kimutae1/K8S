kubectl 설치하기
kubectl은 쿠버네티스 클러스터에 명령을 내리는 CLI입니다.

쿠버네티스는 오브젝트 생성, 수정 혹은 삭제와 관련한 동작을 수행하기 위해 쿠버네티스 API를 사용합니다. 이때, kubectl CLI를 사용하면 해당 명령어가 쿠버네티스 API를 호출해 관련 동작을 수행합니다.

여기 를 클릭하여 배포할 Amazon EKS 버전과 상응하는 kubectl를 설치합니다. 본 실습에서는 가장 최신의 kubectl 바이너리를 설치합니다(2021년 9월 기준 1.21).

sudo curl -o /usr/local/bin/kubectl  \
   https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.13/2022-10-31/bin/linux/amd64/kubectl

sudo chmod +x /usr/local/bin/kubectl

아래의 명령어를 통해, 최신의 kubectl이 설치되었는지 확인합니다.

kubectl version --client=true --short=true

# 출력되는 결과 값
Client Version: v1.23.13-eks-fb459a0
Previous
Next

그 외의 다른 툴들 설치하기
jq 설치하기
jq는 JSON 형식의 데이터를 다루는 커맨드라인 유틸리티입니다. 아래의 명령어를 통해, jq를 설치합니다.

sudo yum install -y jq

bash-completion 설치하기
Bash 쉘에서 kubectl completion script는 kubectl completion bash 명령어를 통해 생성할 수 있습니다. 쉘에 completion script를 소싱하면 kubectl 명령어의 자동 완성을 가능하게 만들 수 있습니다. 하지만 이런 completion script는 bash-completion에 의존하기 때문에 아래의 명령어를 통해, bash-completion 을 설치해야 합니다.

sudo yum install -y bash-completion

Install Git
Git Downloader  링크를 클릭하여 깃을 설치한다.

Python 설치하기
CDK for Python을 이용하기 떄문에 python 을 설치한다. Cloud9 환경에는 기본적으로 Python이 설치되어 있다. Python Installer  링크에서 적절한 패키지를 선택하여 다운로드 및 설치를 진행한다.

python --version
python3 --version

PIP 확인
Python의 패키지들을 설치하고 관리하는 매니저인 PIP설치 여부를 확인한다. 일정 버전 이상의 Python에 기본적으로 설치되어 있다.

pip
pip3

CodeCommit을 이용하기 위해 9.0.3 버전 이상의 pip가 필요하기 떄문에 아래의 명령을 수행하여 pip를 업데이트 진행한다.

curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

만약 설치되어 있지 않다면 pip install page  의 가이드 대로 인스톨을 진행하거나 최신 버전의 Python으로 설치를 권장한다.


eksctl 이란 EKS 클러스터를 쉽게 생성 및 관리하는 CLI 툴입니다. Go 언어로 쓰여 있으며 CloudFormation 형태로 배포됩니다.

아래의 명령어를 통해, 최신의 eksctl 바이너리를 다운로드 합니다.

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

바이너리를 /usr/local/bin으로 옮깁니다.

sudo mv -v /tmp/eksctl /usr/local/bin

아래의 명령어를 통해 설치 여부를 확인합니다.

eksctl version

현재 실습이 진행되고 있는 리전을 기본 값으로 하도록 aws cli를 설정합니다.
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')

echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
    
aws configure set default.region ${AWS_REGION}

설정한 리전 값을 확인합니다.

aws configure get default.region

현재 실습을 진행하는 계정 ID를 환경 변수로 등록합니다.
export ACCOUNT_ID=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.accountId')

echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile


aws_secret_access_key = bDEBuEJMcheNljCtV7HKLbe6vte0A01C8o2/HNpE
export ACCOUNT_ID = 911781391110
export AWS_REGION = ap-northeast-2
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com



git clone https://github.com/joozero/amazon-eks-flask.git
