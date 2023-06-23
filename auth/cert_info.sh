#!/bin/bash

#ca_data=$(kubectl config view -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' )
#echo $ca_data
# kube/config 파일 경로
#kubeconfig_file="/path/to/kube/config"
#
## kube/config 파일에서 certificate-authority-data 값을 추출
#ca_data=$(jq -r '.clusters[0].cluster."certificate-authority-data"' "$kubeconfig_file")
#
## certificate-authority-data 값을 PEM 형식으로 디코딩
#ca_cert=$(echo "$ca_data" | base64 --decode | openssl x509 -inform DER -outform PEM)
#
## 인증서 정보 출력
#echo "$ca_cert"

# kube/config 파일 경로
#kubeconfig_file="/home/kth/.kube/config"
#
## kube/config 파일에서 certificate-authority-data 값을 추출
#ca_data=$(grep -oP 'certificate-authority-data:\K.*' "$kubeconfig_file")
#
## certificate-authority-data 값을 PEM 형식으로 디코딩
#ca_cert=$(echo "$ca_data" | base64 --decode | openssl x509 -inform DER -outform PEM)
#
## 인증서 정보 출력
#echo "$ca_cert"
#
#kubeconfig_file="/home/kth/.kube/config"
#
## kube/config 파일에서 certificate-authority-data 값을 추출
#ca_data=$(grep -oP 'certificate-authority-data:\K.*' "$kubeconfig_file")
#
## certificate-authority-data 값을 PEM 형식으로 디코딩
#ca_cert=$(echo "$ca_data" | base64 --decode | openssl x509 -inform DER -outform PEM)
#
## 인증서 정보 출력
#echo "$ca_cert"

#!/bin/bash

# kube/config 파일 경로
kubeconfig_file="/home/kth/.kube/config"

# kube/config 파일에서 certificate-authority-data 값을 추출
ca_data=$(grep -oP 'certificate-authority-data:\K.*' "$kubeconfig_file")

# certificate-authority-data 값을 PEM 형식으로 디코딩
  echo "$cert"
done