❯ kubectl get rolebindings -A
NAMESPACE     NAME                                                           ROLE                                                  AGE
default       eks:az-poller                                                  Role/eks:az-poller                                    4d2h
kube-public   system:controller:bootstrap-signer                             Role/system:controller:bootstrap-signer               4d2h
kube-system   eks-vpc-resource-controller-rolebinding                        Role/eks-vpc-resource-controller-role                 4d2h
kube-system   eks:addon-manager                                              Role/eks:addon-manager                                4d2h
kube-system   eks:authenticator                                              Role/eks:authenticator                                4d2h
kube-system   eks:az-poller                                                  Role/eks:az-poller                                    4d2h
kube-system   eks:certificate-controller                                     Role/eks:certificate-controller                       4d2h
kube-system   eks:cloud-controller-manager:apiserver-authentication-reader   Role/extension-apiserver-authentication-reader        4d2h
kube-system   eks:fargate-manager                                            Role/eks:fargate-manager                              4d2h
kube-system   eks:k8s-metrics                                                Role/eks:k8s-metrics                                  4d2h
kube-system   eks:node-manager                                               Role/eks:node-manager                                 4d2h
kube-system   system::extension-apiserver-authentication-reader              Role/extension-apiserver-authentication-reader        4d2h
kube-system   system::leader-locking-kube-controller-manager                 Role/system::leader-locking-kube-controller-manager   4d2h
kube-system   system::leader-locking-kube-scheduler                          Role/system::leader-locking-kube-scheduler            4d2h
kube-system   system:controller:bootstrap-signer                             Role/system:controller:bootstrap-signer               4d2h
kube-system   system:controller:cloud-provider                               Role/system:controller:cloud-provider                 4d2h
kube-system   system:controller:token-cleaner                                Role/system:controller:token-cleaner                  4d2h


❯ kubectl get clusterrolebindings
NAME                                                   ROLE                                                               AGE
aws-node                                               ClusterRole/aws-node                                               4d3h
cluster-admin                                          ClusterRole/cluster-admin                                          4d3h
eks:addon-cluster-admin                                ClusterRole/cluster-admin                                          4d3h
eks:addon-manager                                      ClusterRole/eks:addon-manager                                      4d3h
eks:certificate-controller                             ClusterRole/system:controller:certificate-controller               4d3h
eks:certificate-controller-approver                    ClusterRole/eks:certificate-controller-approver                    4d3h
eks:certificate-controller-signer                      ClusterRole/eks:certificate-controller-signer                      4d3h
eks:cloud-controller-manager                           ClusterRole/eks:cloud-controller-manager                           4d3h
eks:cloud-provider-extraction-migration                ClusterRole/eks:cloud-provider-extraction-migration                4d3h
eks:cluster-event-watcher                              ClusterRole/eks:cluster-event-watcher                              4d3h
eks:fargate-manager                                    ClusterRole/eks:fargate-manager                                    4d3h
eks:fargate-scheduler                                  ClusterRole/eks:fargate-scheduler                                  4d3h
eks:k8s-metrics                                        ClusterRole/eks:k8s-metrics                                        4d3h
eks:kube-proxy                                         ClusterRole/system:node-proxier                                    4d3h
eks:kube-proxy-fargate                                 ClusterRole/system:node-proxier                                    4d3h
eks:kube-proxy-windows                                 ClusterRole/system:node-proxier                                    4d3h
eks:node-bootstrapper                                  ClusterRole/eks:node-bootstrapper                                  4d3h
eks:node-manager                                       ClusterRole/eks:node-manager                                       4d3h
eks:nodewatcher                                        ClusterRole/eks:nodewatcher                                        4d3h
eks:pod-identity-mutating-webhook                      ClusterRole/eks:pod-identity-mutating-webhook                      4d3h
eks:podsecuritypolicy:authenticated                    ClusterRole/eks:podsecuritypolicy:privileged                       4d3h
eks:tagging-controller                                 ClusterRole/eks:tagging-controller                                 4d3h
system:basic-user                                      ClusterRole/system:basic-user                                      4d3h
system:controller:attachdetach-controller              ClusterRole/system:controller:attachdetach-controller              4d3h
system:controller:certificate-controller               ClusterRole/system:controller:certificate-controller               4d3h
system:controller:clusterrole-aggregation-controller   ClusterRole/system:controller:clusterrole-aggregation-controller   4d3h
system:controller:cronjob-controller                   ClusterRole/system:controller:cronjob-controller                   4d3h
system:controller:daemon-set-controller                ClusterRole/system:controller:daemon-set-controller                4d3h
system:controller:deployment-controller                ClusterRole/system:controller:deployment-controller                4d3h
system:controller:disruption-controller                ClusterRole/system:controller:disruption-controller                4d3h
system:controller:endpoint-controller                  ClusterRole/system:controller:endpoint-controller                  4d3h
system:controller:endpointslice-controller             ClusterRole/system:controller:endpointslice-controller             4d3h
system:controller:endpointslicemirroring-controller    ClusterRole/system:controller:endpointslicemirroring-controller    4d3h
system:controller:ephemeral-volume-controller          ClusterRole/system:controller:ephemeral-volume-controller          4d3h
system:controller:expand-controller                    ClusterRole/system:controller:expand-controller                    4d3h
system:controller:generic-garbage-collector            ClusterRole/system:controller:generic-garbage-collector            4d3h
system:controller:horizontal-pod-autoscaler            ClusterRole/system:controller:horizontal-pod-autoscaler            4d3h
system:controller:job-controller                       ClusterRole/system:controller:job-controller                       4d3h
system:controller:namespace-controller                 ClusterRole/system:controller:namespace-controller                 4d3h
system:controller:node-controller                      ClusterRole/system:controller:node-controller                      4d3h
system:controller:persistent-volume-binder             ClusterRole/system:controller:persistent-volume-binder             4d3h
system:controller:pod-garbage-collector                ClusterRole/system:controller:pod-garbage-collector                4d3h
system:controller:pv-protection-controller             ClusterRole/system:controller:pv-protection-controller             4d3h
system:controller:pvc-protection-controller            ClusterRole/system:controller:pvc-protection-controller            4d3h
system:controller:replicaset-controller                ClusterRole/system:controller:replicaset-controller                4d3h
system:controller:replication-controller               ClusterRole/system:controller:replication-controller               4d3h
system:controller:resourcequota-controller             ClusterRole/system:controller:resourcequota-controller             4d3h
system:controller:root-ca-cert-publisher               ClusterRole/system:controller:root-ca-cert-publisher               4d3h
system:controller:route-controller                     ClusterRole/system:controller:route-controller                     4d3h
system:controller:service-account-controller           ClusterRole/system:controller:service-account-controller           4d3h
system:controller:service-controller                   ClusterRole/system:controller:service-controller                   4d3h
system:controller:statefulset-controller               ClusterRole/system:controller:statefulset-controller               4d3h
system:controller:ttl-after-finished-controller        ClusterRole/system:controller:ttl-after-finished-controller        4d3h
system:controller:ttl-controller                       ClusterRole/system:controller:ttl-controller                       4d3h
system:coredns                                         ClusterRole/system:coredns                                         4d3h
system:discovery                                       ClusterRole/system:discovery                                       4d3h
system:kube-controller-manager                         ClusterRole/system:kube-controller-manager                         4d3h
system:kube-dns                                        ClusterRole/system:kube-dns                                        4d3h
system:kube-scheduler                                  ClusterRole/system:kube-scheduler                                  4d3h
system:monitoring                                      ClusterRole/system:monitoring                                      4d3h
system:node                                            ClusterRole/system:node                                            4d3h
system:node-proxier                                    ClusterRole/system:node-proxier                                    4d3h
system:public-info-viewer                              ClusterRole/system:public-info-viewer                              4d3h
system:service-account-issuer-discovery                ClusterRole/system:service-account-issuer-discovery                4d3h
system:volume-scheduler                                ClusterRole/system:volume-scheduler                                4d3h
vpc-resource-controller-rolebinding                    ClusterRole/vpc-resource-controller-role                           4d3h


❯ eksctl get iamidentitymapping --cluster kstadium --region=ap-northeast-2
ARN                                                                                             USERNAME                        GROUPS                                                  ACCOUNT
arn:aws:iam::911781391110:role/eksctl-kstadium-cluster-FargatePodExecutionRole-1B74XW375US33    system:node:{{SessionName}}     system:bootstrappers,system:nodes,system:node-proxier


 eksctl get iamidentitymapping --cluster kstadium --region=ap-northeast-2
ARN                                                                                             USERNAME                        GROUPS                                                  ACCOUNT
arn:aws:iam::911781391110:role/eksctl-kstadium-cluster-FargatePodExecutionRole-1B74XW375US33    system:node:{{SessionName}}     system:bootstrappers,system:nodes,system:node-proxier
arn:aws:iam::911781391110:user/dorian.kim@themedium.io   


curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/aws-auth-cm.yaml
