helm repo add argo https://argoproj.github.io/argo-helm

cat << 'EOF' > $env-argo-values.yaml
configs:
  secret:
    argocdServerAdminPassword: "$2a$10$tbnDbXHIEBvaq2L2ANcOv.m/D5YSV2syzAJl.Q7/Vr3oIcwrl6mUG%"
    argocdServerAdminPasswordMtime: "2023-08-02T15:04:05Z"
    
  repositories:
    private-repo:
      url: git@github.com:kstadium/octet-token-change-eks.git
      name: octet-token-change-eks
      type: git
      sshPrivateKey: |
        -----BEGIN OPENSSH PRIVATE KEY-----
        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
        -----END OPENSSH PRIVATE KEY-----

  private-repo:
    url: git@github.com:kstadium/kstadium-k8s.git
    name: kstadium-k8s
    type: git
    sshPrivateKey: |
      -----BEGIN OPENSSH PRIVATE KEY-----
      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
      P6KiOv/zxpZ6QFAAAAB2xpb0BMaW8BAgM=
      -----END OPENSSH PRIVATE KEY-----
EOF



cat << EOF >> $env-argo-values.yaml
  clusterCredentials:
     - name: ${env}-${service_zone}-service
       server: $service_cluster_endpoint
       labels:
         argocd.argoproj.io/secret-type: cluster
       config:
         kustomize.buildOptions: --enable-helm=true
         awsAuthConfig:
           clusterName: ${env}-${service_zone}-service
           roleARN: $eks_sa_role
         tlsClientConfig:
           insecure: false # TLS 인증x
           #insecure: true # TLS 인증x
           caData: "$service_cluster_ca"
# - name: ${env}-${service_zone}-gndchain
#        server: $gndchain_cluster_endpoint
#        config:
#          awsAuthConfig:
#            clusterName: ${env}-${service_zone}-gndchain
#            roleARN: $eks_sa_role
#          tlsClientConfig:
#            insecure: false # TLS 인증x
#            caData: "$gndchain_cluster_ca"
EOF

cat << EOF >> $env-argo-values.yaml
global:
  logging:
    format: text
    level: debug

server:
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: alb
      alb.ingress.kubernetes.io/load-balancer-name: alb-${cluster_name}-argo
      alb.ingress.kubernetes.io/group.name: tg-${cluster_name}-argo
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/certificate-arn: $cert_arn
      alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-2016-08
      alb.ingress.kubernetes.io/backend-protocol: HTTPS
      alb.ingress.kubernetes.io/healthcheck-path: /
      alb.ingress.kubernetes.io/target-type: 'ip'
      alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
      alb.ingress.kubernetes.io/ssl-redirect: '443'
      alb.ingress.kubernetes.io/actions.ssl-redirect: {"Type": "redirect", "RedirectConfig": { "Protocol": "HTTPS", "Port": "443", "StatusCode": "HTTP_301"}}
      external-dns.alpha.kubernetes.io/hostname: argo.${dns_zone}
    paths:
      - /
    pathType: Prefix

  serviceAccount:
    create: true
    name: argocd-server
    annotations: 
        eks.amazonaws.com/role-arn: $eks_sa_role
    automountServiceAccountToken: true
controller:
  serviceAccount:
    create: true
    name: argocd-application-controller
    annotations: 
        eks.amazonaws.com/role-arn: $eks_sa_role
    automountServiceAccountToken: true


EOF


kubectl create namespace managed
helm upgrade --install -f $env-argo-values.yaml --namespace managed argocd argo/argo-cd
