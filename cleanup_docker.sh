#!/bin/bash

echo "Stop specific containers"
function containers {
if [ -z "$1" ]; then
  echo "Can't find container"
else
  docker stop $1
fi
}
containers $(docker ps -f name=web| sed 1d)
containers $(docker ps -f name=db| sed 1d)


echo "Remove ALL containers"
for variable in `docker ps -a -f status=exited -q`
do
echo "$variable"
docker rm $variable
done


echo "Remove ALL images"
#for variable in `docker images | awk '{ print $3 }' | awk 'FNR>1'`
for variable in `docker images -q`
do
echo "$variable"
docker rmi -f $variable
done
