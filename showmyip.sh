#!/bin/bash

MYAWS="aws --profile $1"

EXTIP=`dig @resolver1.opendns.com ANY myip.opendns.com +short`
echo "Current IP is $EXTIP"
CHECK=`$MYAWS ec2 describe-security-groups --group-id $2 | grep $EXTIP`

if [ -n "$CHECK" ]; then
  echo "Nothing to do, just exit"
  exit 1
fi

$MYAWS ec2 authorize-security-group-ingress --group-id $2 --ip-permissions IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges='[{CidrIp='${EXTIP}/32',Description='Office_IP'}]'
echo "Done"
