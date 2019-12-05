#!/bin/bash
# From this script you may able to check background running process of DB.
# NOTE : Change Mysql Password only if you are running this script on other server.
# Script Usage instructions :
# Execute the script:
#
# ./showsqlprocesslist.sh > showsqlprocesslist.out
#&
# Tail the output:
# tail -f showsqlprocesslist.out
#
while [ 1 -le 1 ]
do
  mysql --port=3306 --protocol=tcp --password="mysql-password" --user=root --host="RDS/Server Endpoint" -e "show processlist\G" | grep Info | grep -v processlist | grep -v "Info: NULL";
done
