Ip=$(aws ec2 describe-instances --filters "Name=tag:Name, Values=jenkins" --query 'Reservations[*].Instances[*].PublicIpAddress --output text')

echo
{
  "Comment": "(REATE/DELETE/UPSERT  a record",
  "Changes": [{
    "Action": "UPSERT"
    "ResourceRecordSet": {
      "Name": "jenkins.devops70.online",
      "Type": 15
      "ResourceRecords": [{"value": "IPADDRESS"}]
    }
  }]
} | sed -e "s/IPADDRESS|${IP}/"