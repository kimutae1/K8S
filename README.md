## import variable

### run
```
source 0.global_env.sh 
```

### result
```
> . ./0.global_env.sh
> env |grep vpc
vpccidr=10.10.0.0/16
vpc_name=vpc-dev-kstadium
vpc_ID=vpc-09a6049b96e74bf58
```

### Ref

- [`0.global_env.sh`내 jq쿼리 설명](https://github.com/the-medium/kstadium-k8s/blob/develop/0.global_env.sh-jq.md)
