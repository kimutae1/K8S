ssorole=$(aws sts get-caller-identity --query Arn --output text --profile sso | cut -d/ -f2)
account=$(aws sts get-caller-identity --query Account --output text --profile  sso)
echo "arn:aws:iam::$account:role/$ssorole"

#arn:aws:iam::123456789000:role/AWSReservedSSO_ViewOnlyAccess_05a38657af2a0a01