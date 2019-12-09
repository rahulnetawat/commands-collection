#!/bin/bash
DBHOST='mysql-host'
DBUSER='mysql-user'
DBPASS='mysql-password'
mysql -u $DBUSER -p$DBPASS -e 'show databases'
echo -n "Enter Database Name: "
read DBNAME
DIR=/opt/backup-scripts/$DBNAME
mkdir $DIR
tbl_count=1
for t in $(mysql -NBA -h $DBHOST -u $DBUSER -p$DBPASS -D $DBNAME -e 'show tables')
do
   echo "DUMPING TABLE ${tbl_count}: $DBNAME.$t"
   mysqldump -h $DBHOST -u $DBUSER -p$DBPASS $DBNAME $t > $DIR/$t.sql
   tbl_count=$(( $tbl_count + 1 ))
done
