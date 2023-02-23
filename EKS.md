���������� curl�� ����Ͽ� kubectl ���̳ʸ� ��ġ
���� ������� �ֽ� �������� �ٿ�ε��Ѵ�.

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
����:
Ư�� ������ �ٿ�ε��Ϸ���, $(curl -L -s https://dl.k8s.io/release/stable.txt) ��� �κ��� Ư�� �������� �ٲ۴�.

���� ���, ���������� ���� v1.26.0�� �ٿ�ε��Ϸ���, ������ �Է��Ѵ�.

curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl

kubectl: OK

kubectl ��ġ

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
����:
��� �ý��ۿ� root ���� ������ ������ ���� �ʴ���, ~/.local/bin ���͸��� kubectl�� ��ġ�� �� �ִ�.

chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
# �׸��� ~/.local/bin �� $PATH�� �պκ� �Ǵ� �޺κп� �߰�

kubectl version --client


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

## eks ctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

