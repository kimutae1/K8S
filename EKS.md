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


