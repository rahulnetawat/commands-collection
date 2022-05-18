#!/bin/bash
#removing <none> images
none_images=`docker images | grep "^<none>" | awk '{ print $3 }'`
if [ ! -z $none_images ]
then
docker rmi $(docker images | grep "^<none>" | awk '{ print $3 }')
else
echo "No <none> images found for cleanup"
fi

#removing Dangling images
dangling_images=`docker images -f "dangling=true" -q`
if [ ! -z $dangling_images  ]
then
   docker rmi $(docker images -f "dangling=true" -q)
else
   echo "No Dangling images found for cleanup"
fi
echo "Docker Images cleanup Done"

#removing stop-or-exited Containers
stopped_containers=`docker ps -a -q -f "status=exited"`
if [ ! -z $stopped_containers ]
then
   docker rm $(docker ps -a -q -f status=exited)
else
   echo "No Stopped containers found for cleanup"
fi
echo "Docker containers cleanup Done"
