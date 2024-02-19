#!/bin/bash

# IAM 권한 확인
account_id=$(aws sts get-caller-identity | jq -r '.Account')

if [ "$account_id" != "033240183289" ]; then
    echo "IAM 권한이 없습니다. 스크립트를 종료합니다."
    exit 1
else
    echo "Account ID: $account_id"
fi

#리전 설정 for ECR UPLOAD
if [ "$account_id" = "911781391110" ] || [ "$account_id" = "779626203419" ] || [ "$account_id" = "003072849841" ]; then region_code="ap-northeast-2"; elif [ "$account_id" = "033240183289" ]; then region_code="ap-southeast-1"; fi


DATE=`date +%Y%m%d%H%M`
KUBECTL_URL='https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.2/2023-10-17/bin/linux/amd64/kubectl'

# 도커파일 생성
cat <<EOF > Dockerfile
FROM amazon/aws-cli

RUN yum upgrade -y
RUN yum install -y jq perl curl git tar  bash-completion  wget gcc make

#Neovim 패키지 다운로드 설치
#RUN wget https://github.com/neovim/neovim-releases/releases/download/nightly/nvim-linux64.tar.gz
#RUN tar xzvf nvim-linux64.tar.gz
#RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
#RUN echo 'alias vi=\${PWD}/nvim-linux64/bin/nvim'   >> /root/.bashrc


#사용할 폴더 생성 
WORKDIR /app
RUN mkdir -p ~/.kube/ ~/.aws

#Neovim 로컬 파일로 설치
COPY nvim-linux64.tar.gz /bin/
RUN cd /bin; tar -xvzf  /bin/nvim-linux64.tar.gz  
COPY  .config  /root/.config
RUN echo 'alias vi=/bin/nvim-linux64/bin/nvim'   >> /root/.bashrc



#환경변수 설정 global 에서 설정한 변수를 가져옴
# ENV REGION ap-southeast-1
# ENV env prd  
# ENV CLUSTER_ENV develop
ENV TEST 1

#kubectl 설치
#RUN bash -c 'cd /usr/local/bin &&  wget  https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.2/2023-10-17/bin/linux/amd64/kubectl -P /usr/local/bin &&   chmod +x ./kubectl &&   mkdir -p \$HOME/bin &&   cp ./kubectl \$HOME/bin/kubectl &&   export PATH=\$HOME/bin:\$PATH &&   echo "export PATH=\$HOME/bin:\$PATH" >> ~/.bashrc '
COPY kubectl /usr/local/bin

#KREW  설치
#RUN bash -c '   cd /usr/local/bin && OS="\$(uname | tr "[:upper:]" "[:lower:]")" &&   ARCH="\$(uname -m | sed -e "s/x86_64/amd64/" -e "s/\(arm\)\(64\)\?.*/\1\2/" -e "s/aarch64$/arm64/")" && PLATFORM=Linux_\$ARCH &&  KREW="krew-\${OS}_\${ARCH}"'   
#curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/\${KREW}.tar.gz" &&  tar zxvf "\${KREW}.tar.gz" &&   ./"\${KREW}" install krew && \
COPY krew-linux_amd64.tar.gz /usr/local/bin/
#RUN cd /usr/local/bin ; tar -xvzf krew-linux_amd64.tar.gz ;  ./krew-linux_amd64 install krew 


#eksctl 설치
#curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_\$PLATFORM.tar.gz"&& tar -xzf eksctl_\$PLATFORM.tar.gz && rm eksctl_\$PLATFORM.tar.gz '
COPY  eksctl_Linux_amd64.tar.gz /usr/local/bin/
RUN cd /usr/local/bin/ ; tar -xvzf eksctl_Linux_amd64.tar.gz; chmod +x ./kubectl


#편의 설정 alias
#ENV PATH="/root/.krew/bin:\${PATH}"
RUN echo 'export PATH="\${KREW_ROOT:-\$HOME/.krew}/bin:\$PATH"' >> /root/.bashrc
RUN echo 'source /usr/share/bash-completion/bash_completion' >> ~/.bashrc
RUN echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc
RUN echo "source <(kubectl completion bash)" >> /root/.bashrc
#RUN kubectl krew install ctx
RUN echo "alias k=kubectl"  >> /root/.bashrc
#RUN echo -e "[default]\nregion = ${REGION}" >> ~/.aws/config
RUN echo "alias kubectx='kubectl ctx'"  >> /root/.bashrc
RUN echo "set -o vi"  >> /root/.bashrc
#!/bin/bash

# IAM 권한 확인
account_id=$(aws sts get-caller-identity | jq -r '.Account')

if [ "$account_id" != "033240183289" ]; then
    echo "IAM 권한이 없습니다. 스크립트를 종료합니다."
    exit 1
else
    echo "Account ID: $account_id"
fi

#리전 설정 for ECR UPLOAD
if [ "$account_id" = "911781391110" ] || [ "$account_id" = "779626203419" ] || [ "$account_id" = "003072849841" ]; then region_code="ap-northeast-2"; elif [ "$account_id" = "033240183289" ]; then region_code="ap-southeast-1"; fi


DATE=`date +%Y%m%d%H%M`
KUBECTL_URL='https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.2/2023-10-17/bin/linux/amd64/kubectl'

# 도커파일 생성
cat <<EOF > Dockerfile
FROM amazon/aws-cli

RUN yum upgrade -y
RUN yum install -y jq perl curl git tar  bash-completion  wget gcc make

#Neovim 패키지 다운로드 설치
#RUN wget https://github.com/neovim/neovim-releases/releases/download/nightly/nvim-linux64.tar.gz
#RUN tar xzvf nvim-linux64.tar.gz
#RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
#RUN echo 'alias vi=${PWD}/nvim-linux64/bin/nvim'   >> /root/.bashrc


#사용할 폴더 생성 
WORKDIR /app
RUN mkdir -p ~/.kube/ ~/.aws

#Neovim 로컬 파일로 설치
COPY nvim-linux64.tar.gz /bin/
RUN cd /bin; tar -xvzf  /bin/nvim-linux64.tar.gz  
COPY  .config  /root/.config
RUN echo 'alias vi=/bin/nvim-linux64/bin/nvim'   >> /root/.bashrc



#환경변수 설정 global 에서 설정한 변수를 가져옴
# ENV REGION ap-southeast-1
# ENV env prd  
# ENV CLUSTER_ENV develop
ENV TEST 1

#kubectl 설치
#RUN bash -c 'cd /usr/local/bin &&  wget  https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.2/2023-10-17/bin/linux/amd64/kubectl -P /usr/local/bin &&   chmod +x ./kubectl &&   mkdir -p $HOME/bin &&   cp ./kubectl $HOME/bin/kubectl &&   export PATH=$HOME/bin:$PATH &&   echo "export PATH=$HOME/bin:$PATH" >> ~/.bashrc '
COPY kubectl /usr/local/bin

#KREW  설치
#RUN bash -c '   cd /usr/local/bin && OS="$(uname | tr "[:upper:]" "[:lower:]")" &&   ARCH="$(uname -m | sed -e "s/x86_64/amd64/" -e "s/\(arm\)\(64\)\?.*/\1\2/" -e "s/aarch64$/arm64/")" && PLATFORM=Linux_$ARCH &&  KREW="krew-${OS}_${ARCH}"'   
#curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&  tar zxvf "${KREW}.tar.gz" &&   ./"${KREW}" install krew && \
COPY krew-linux_amd64.tar.gz /usr/local/bin/
#RUN cd /usr/local/bin ; tar -xvzf krew-linux_amd64.tar.gz ;  ./krew-linux_amd64 install krew 


#eksctl 설치
#curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"&& tar -xzf eksctl_$PLATFORM.tar.gz && rm eksctl_$PLATFORM.tar.gz '
COPY  eksctl_Linux_amd64.tar.gz /usr/local/bin/
RUN cd /usr/local/bin/ ; tar -xvzf eksctl_Linux_amd64.tar.gz; chmod +x ./kubectl


#편의 설정 alias
#ENV PATH="/root/.krew/bin:${PATH}"
RUN echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> /root/.bashrc
RUN echo 'source /usr/share/bash-completion/bash_completion' >> ~/.bashrc
RUN echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc
RUN echo "source <(kubectl completion bash)" >> /root/.bashrc
#RUN kubectl krew install ctx
RUN echo "alias k=kubectl"  >> /root/.bashrc
#RUN echo -e "[default]\nregion = ${REGION}" >> ~/.aws/config
RUN echo "alias kubectx='kubectl ctx'"  >> /root/.bashrc
RUN echo "set -o vi"  >> /root/.bashrc
#CMD ["bash"]

# #Cluster 정보 저장
# ENTRYPOINT bash -c 'clusters=$(aws eks list-clusters --output json --query "clusters[]") && #   for cluster_name in $(echo $clusters | jq -r ".[]"); do #     eksctl utils write-kubeconfig --cluster="$cluster_name"; #   done &&# tail -f /dev/null \ 
#   '

#ENTRYPOINT  tail -f /dev/null ##for  POD TEST
EOF

# 도커 빌드
docker build -t devops/goldimage-docker .

#ECR_ENDPOINT=${Account}.dkr.ecr.${region_code}.amazonaws.com/devops/goldimage-docker
ECR_ENDPOINT=public.ecr.aws/j1t6w1m1/ekstools
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j1t6w1m1
#echo $ECR_ENDPOINT
# echo ${region_code}

#도커 TAGS
docker tag devops/goldimage-docker:latest ${ECR_ENDPOINT}:latest
docker tag devops/goldimage-docker:latest ${ECR_ENDPOINT}:${DATE}

#docker ECR push
docker push ${ECR_ENDPOINT}:latest 
docker push ${ECR_ENDPOINT}:${DATE}

#CMD ["bash"]

# #Cluster 정보 저장
# ENTRYPOINT bash -c 'clusters=$(aws eks list-clusters --output json --query "clusters[]") && #   for cluster_name in $(echo $clusters | jq -r ".[]"); do #     eksctl utils write-kubeconfig --cluster="$cluster_name"; #   done &&# tail -f /dev/null \ 
#   '

#ENTRYPOINT  tail -f /dev/null ##for  POD TEST
EOF

# 도커 빌드
docker build -t devops/goldimage-docker .

#ECR_ENDPOINT=${Account}.dkr.ecr.${region_code}.amazonaws.com/devops/goldimage-docker
ECR_ENDPOINT=public.ecr.aws/j1t6w1m1/ekstools
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/j1t6w1m1
#echo $ECR_ENDPOINT
# echo ${region_code}

#도커 TAGS
docker tag devops/goldimage-docker:latest ${ECR_ENDPOINT}:latest
docker tag devops/goldimage-docker:latest ${ECR_ENDPOINT}:${DATE}

#docker ECR push
docker push ${ECR_ENDPOINT}:latest 
docker push ${ECR_ENDPOINT}:${DATE}

