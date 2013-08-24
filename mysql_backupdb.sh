#!/bin/bash
  
PATH=/usr/sbin:/sbin:/bin:/usr/bin
  
MyUSER="your_db_user"
MyPASS="your_db_password"
MyHOST="your_db_host"
 
SUBFOLDER="$(date +"%Y-%m-%d")"
DEST="/somewhere/on/your/server"
MDB="$DEST/backup/$SUBFOLDER"
 
if [ ! -d $MDB ]
then
    mkdir -p $MDB >/dev/null 2>&1 && echo "Directory $MDB created." ||  echo "Error: Failed to create $MDB directory."
else
    echo "Error: $MDB directory exits!"
fi
 
NOW="$(date +"%Y-%m-%d_%H-%M-%S")"
 
FILE=""
 
DBS="$(mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse 'show databases')"
  
for db in $DBS
do
    FILE="$MDB/$db.$NOW.sql.gz"
    mysqldump -u $MyUSER -h $MyHOST -p$MyPASS --complete-insert $db | gzip -9 > $FILE
    echo "Backup $FILE.....DONE"
done
- See more at: http://4rapiddev.com/mysql/shell-script-backup-all-mysql-databases-in-linux/#sthash.hQ52F2iO.dpuf
