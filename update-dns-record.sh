Ip=$( aws ec2 describe-instances --filters "Name=tag:Name, Values=jenkins" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)

echo '
{
  "Comment": "CREATE/DELETE/UPSERT  a record",
  "Changes": [{
    "Action": "UPSERT"
    "ResourceRecordSet": {
      "Name": "jenkins.devops70.online",
      "Type": 15
      "ResourceRecords": [{"value": "IPADDRESS"}]
    }
  }]
}' | sed -e "s/IPADDRESS|${IP}/" >/tmp/jenkins.json

ZONE_ID="Z03482602CK395N17NV00"
aws rout53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch file:///tmp/recordjenkins.json | jq .
