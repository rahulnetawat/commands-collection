#!/bin/bash
# Instructions to run this bash script.
# source filename
# then run dockerip
function dockerip {

  if (( $# != 1 ))
    then
        for d in $(docker ps -q)
        do
            name=$(docker inspect -f {{.Name}} $d)
            ip=$(docker inspect -f {{.NetworkSettings.IPAddress}} $d)
            printf "%-15s | %15s\n" $name $ip
        done
  fi
}
