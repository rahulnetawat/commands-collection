#!/bin/bash
DBHOST=localhost
DBUSER='mysql-user'
DBPASS='mysql-password'

mysql -u $DBUSER -p$DBPASS -e 'show databases'
echo -n "Enter Database Name to backup: "
read DBNAME

mysqldump -u $DBUSER -p$DBPASS $DBNAME | gzip > $DBNAME-`date +%Y-%m-%d`.sql.gz
mysqldump -u $DBUSER -p$DBPASS --routines --no-create-info --no-data --no-create-db --skip-opt $DBNAME | gzip > $DBNAME-func-`date +%Y-%m-%d`.sql.gz
