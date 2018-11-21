#!/bin/bash
# How to use this script if you want to cleanup your AWS log group in cloudwatch
#./cleanup_logstream.sh name_of_your_log_stream

#If you need to find log stream by name preffix you can use this command
#(just change 'NAME_PREFFIX' to your variant)
#aws logs describe-log-groups --log-group-name-prefix NAME_PREFFIX | jq .logGroups[].logGroupName | tr -d '"'

GROUP=$1

if [ -z $GROUP ]; then
  echo "Please enter name of the log group like - cleanup_logstream.sh name_of_your_log_stream"
  exit 1
fi

for variable in `aws logs describe-log-streams --log-group-name $GROUP | jq .logStreams[].logStreamName | tr -d '"'`
do
echo "$variable"
aws logs delete-log-stream --log-group-name $GROUP  --log-stream-name "$variable"
done
