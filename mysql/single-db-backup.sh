#!/bin/bash
DBHOST=localhost
DBUSER='root'
DBPASS='mysql-password'

mysql -u $DBUSER -h $DBHOST -p$DBPASS -e 'show databases'
echo -n "Enter Database Name to backup: "
read DBNAME

mysqldump -u $DBUSER -h $DBHOST -p$DBPASS $DBNAME | gzip > $DBNAME-`date +%Y-%m-%d`.sql.gz
mysqldump -u $DBUSER -h $DBHOST -p$DBPASS --routines --no-create-info --no-data --no-create-db --skip-opt $DBNAME | gzip > $DBNAME-func-`date +%Y-%m-%d`.sql.gz
