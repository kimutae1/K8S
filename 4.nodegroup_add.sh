
eksctl utils update-legacy-subnet-settings --cluster ${cluster_name}
eksctl create nodegroup --cluster=$cluster_name --name="${cluster_name}-Node" --region $region_code