(

  set -x; cd "$(mktemp -d)" &&

  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&

  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e

 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&

  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&

  tar zxvf krew.tar.gz &&

  KREW=./krew-"${OS}_${ARCH}" &&

  "$KREW" install krew

)