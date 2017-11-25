#!/bin/bash
echo "Backing Up Databases:" 
datetime=`date '+%m-%d-%y-%H-%M-%S'` 
mysqldump -u root -puR7TfwVrcG8ihwg4 --all-databases | gzip > mysql-backup-$datetime.gz
# List databases to backup
DBASELIST=`mktemp` 
mysqlshow -u root -puR7TfwVrcG8ihwg4 | awk '{print $2}' | grep -v Databases | sort >$DBASELIST
# dump them all
for x in `cat $DBASELIST`; do
    echo "Database: $x saved";
    mysqldump --opt -u root -puR7TfwVrcG8ihwg4 $x >$x.sql; done; echo "Zipping files:"
gzip *

