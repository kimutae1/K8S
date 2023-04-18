- groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier
  - system:masters
  rolearn: arn:aws:iam::911781391110:role/eksctl-alb-cluster-FargatePodExecutionRole-52CKZ9Z5VQG1
  username: system:node:{{SessionName}}

- groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier
  - system:masters
  rolearn: arn:aws:iam::911781391110:role/AWSReservedSSO_crypted_devops_1c74128b3bb9822e
  username: system:node:{{SessionName}}



- groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier
  - system:masters
  rolearn: arn:aws:iam::911781391110:role/eksctl-alb-cluster-ServiceRole-16JYWPL08F8K7
  username: system:node:{{SessionName}}


- groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier
  - system:masters
  rolearn: arn:aws:iam::911781391110:role/devops-role
  username: system:node:{{SessionName}}

- groups:
  - system:bootstrappers
  - system:nodes
  - system:node-proxier
  - system:masters
  rolearn: arn:aws:iam::911781391110:role/devops-role/devops-session
  username: system:node:{{SessionName}}
