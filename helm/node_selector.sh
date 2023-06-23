helm install apache4 bitnami/apache -n managed --set nodeSelector."eks\.amazonaws\.com/nodegroup"="nodegroup-dorian11"

