kubectl ��ġ�ϱ�
kubectl�� �����Ƽ�� Ŭ�����Ϳ� ����� ������ CLI�Դϴ�.

�����Ƽ���� ������Ʈ ����, ���� Ȥ�� ������ ������ ������ �����ϱ� ���� �����Ƽ�� API�� ����մϴ�. �̶�, kubectl CLI�� ����ϸ� �ش� ��ɾ �����Ƽ�� API�� ȣ���� ���� ������ �����մϴ�.

���� �� Ŭ���Ͽ� ������ Amazon EKS ������ �����ϴ� kubectl�� ��ġ�մϴ�. �� �ǽ������� ���� �ֽ��� kubectl ���̳ʸ��� ��ġ�մϴ�(2021�� 9�� ���� 1.21).

sudo curl -o /usr/local/bin/kubectl  \
   https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.13/2022-10-31/bin/linux/amd64/kubectl

sudo chmod +x /usr/local/bin/kubectl

�Ʒ��� ��ɾ ����, �ֽ��� kubectl�� ��ġ�Ǿ����� Ȯ���մϴ�.

kubectl version --client=true --short=true

# ��µǴ� ��� ��
Client Version: v1.23.13-eks-fb459a0
Previous
Next

�� ���� �ٸ� ���� ��ġ�ϱ�
jq ��ġ�ϱ�
jq�� JSON ������ �����͸� �ٷ�� Ŀ�ǵ���� ��ƿ��Ƽ�Դϴ�. �Ʒ��� ��ɾ ����, jq�� ��ġ�մϴ�.

sudo yum install -y jq

bash-completion ��ġ�ϱ�
Bash ������ kubectl completion script�� kubectl completion bash ��ɾ ���� ������ �� �ֽ��ϴ�. ���� completion script�� �ҽ��ϸ� kubectl ��ɾ��� �ڵ� �ϼ��� �����ϰ� ���� �� �ֽ��ϴ�. ������ �̷� completion script�� bash-completion�� �����ϱ� ������ �Ʒ��� ��ɾ ����, bash-completion �� ��ġ�ؾ� �մϴ�.

sudo yum install -y bash-completion

Install Git
Git Downloader  ��ũ�� Ŭ���Ͽ� ���� ��ġ�Ѵ�.

Python ��ġ�ϱ�
CDK for Python�� �̿��ϱ� ������ python �� ��ġ�Ѵ�. Cloud9 ȯ�濡�� �⺻������ Python�� ��ġ�Ǿ� �ִ�. Python Installer  ��ũ���� ������ ��Ű���� �����Ͽ� �ٿ�ε� �� ��ġ�� �����Ѵ�.

python --version
python3 --version

PIP Ȯ��
Python�� ��Ű������ ��ġ�ϰ� �����ϴ� �Ŵ����� PIP��ġ ���θ� Ȯ���Ѵ�. ���� ���� �̻��� Python�� �⺻������ ��ġ�Ǿ� �ִ�.

pip
pip3

CodeCommit�� �̿��ϱ� ���� 9.0.3 ���� �̻��� pip�� �ʿ��ϱ� ������ �Ʒ��� ����� �����Ͽ� pip�� ������Ʈ �����Ѵ�.

curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user

���� ��ġ�Ǿ� ���� �ʴٸ� pip install page  �� ���̵� ��� �ν����� �����ϰų� �ֽ� ������ Python���� ��ġ�� �����Ѵ�.


eksctl �̶� EKS Ŭ�����͸� ���� ���� �� �����ϴ� CLI ���Դϴ�. Go ���� ���� ������ CloudFormation ���·� �����˴ϴ�.

�Ʒ��� ��ɾ ����, �ֽ��� eksctl ���̳ʸ��� �ٿ�ε� �մϴ�.

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

���̳ʸ��� /usr/local/bin���� �ű�ϴ�.

sudo mv -v /tmp/eksctl /usr/local/bin

�Ʒ��� ��ɾ ���� ��ġ ���θ� Ȯ���մϴ�.

eksctl version

���� �ǽ��� ����ǰ� �ִ� ������ �⺻ ������ �ϵ��� aws cli�� �����մϴ�.
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')

echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
    
aws configure set default.region ${AWS_REGION}

������ ���� ���� Ȯ���մϴ�.

aws configure get default.region

���� �ǽ��� �����ϴ� ���� ID�� ȯ�� ������ ����մϴ�.
export ACCOUNT_ID=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.accountId')

echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile


aws_secret_access_key = bDEBuEJMcheNljCtV7HKLbe6vte0A01C8o2/HNpE
export ACCOUNT_ID = 911781391110
export AWS_REGION = ap-northeast-2
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com



git clone https://github.com/joozero/amazon-eks-flask.git
